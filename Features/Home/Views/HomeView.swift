

import SwiftUI


struct HomeView: View {
    @StateObject private var viewModel = WeatherViewModel()
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
              }
              .padding(.horizontal, 16)
              .padding(.top, 12)
              
              if viewModel.isLoading {
                  ProgressView("Загрузка...")
                      .padding(.horizontal, 16)
              }
              if let error = viewModel.errorMessage {
                  Text(error)
                      .foregroundStyle(.red)
                      .padding(.horizontal, 16)
              }
              if let weather = viewModel.weather {
                  HourlyForecastSection(items: weather.hourly)
                  DailyForecastSection(items: weather.forecast)
                  VStack(alignment: .leading, spacing: 10){
                      Text("\(weather.city), \(weather.country)")
                          .font(.title2)
                          .fontWeight(.semibold)
                      
                      Text("\(Int(weather.temperature))")
                          .font(.system(size: 54, weight: .bold))
                      
                      Text(weather.description)
                          .foregroundStyle(.secondary)
                  }
                  .padding(.horizontal, 16)
              } else if !viewModel.isLoading && viewModel.errorMessage == nil {
                  Text("Нет данных")
                      .foregroundStyle(.secondary)
                      .padding(.horizontal, 16)
              }
          }
        }
      .task {
          await viewModel.loadWeather(for: viewModel.city)
      }
    }
}
