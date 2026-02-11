

import SwiftUI


struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var city = "Almaty"
    var body: some View {
        VStack(spacing: 20) {
            TextField("Введите город", text: $city)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button {
                Task { await viewModel.loadWeather(for: city)}
            } label: {
                Text("Загрузить погоду")
            }
            if viewModel.isLoading {
                ProgressView()
            }
            
            if let weather = viewModel.weather {
                VStack(spacing: 8) {
                    Text("\(weather.city), \(weather.country)")
                        .font(.title)
                    Text("\(weather.temperature,specifier: "%.1f")°C")
                        .font(.largeTitle)
                    Text(weather.description)
                        .foregroundStyle(.secondary)
                }
            }
            
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(.red)
            }
            Spacer()
        }
        .padding()
    }
}
