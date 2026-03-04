

import SwiftUI


struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16){
                HStack{
                    TextField("Город", text: $viewModel.city)
                    
                    Button {
                        Task { await viewModel.loadWeather(for: viewModel.city)}
                    } label: {
                        Text("Загрузить")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        locationManager.requestPermission()
                        locationManager.requestLocation()
                    } label: {
                        Image(systemName: "location.fill")
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                
                
                //Content
                Group {
                    if viewModel.isLoading {
                        ProgressView("Загрузка...")
                            .padding(.horizontal, 16)
                    }  else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundStyle(.red)
                            .padding(.horizontal, 16)
                    }  else if let weather = viewModel.weather {
                        CurrentWeatherCard(weather: weather)
                            .padding(.horizontal, 16)
                        HourlyForecastSection(items: weather.hourly)
                            .padding(.horizontal, 16)
                        DailyForecastSection(items: weather.forecast)
                            .padding(.horizontal, 16)
                    } else {
                        Text("Введите город и нажмите Загрузить")
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 16)
                    }
                }
            }
            .padding(.bottom, 24)
        }
        .scrollIndicators(.hidden)
        .task {
            await viewModel.loadWeather(for: viewModel.city)
        }
        
        .onChange(of: locationManager.lastLocation) { _, newsLocation in
            guard let location = newsLocation else { return }
            
            Task {
                await viewModel.loadWeather(for: location)
            }
        }
    }
}
