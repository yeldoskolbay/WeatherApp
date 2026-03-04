
import Foundation
import CoreLocation

@MainActor

final class WeatherViewModel: ObservableObject {
    @Published var city: String = "Almaty"
    @Published var weather: Weather?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let network: WeatherNetworkManager
    
    init(network: WeatherNetworkManager = WeatherNetworkManager()) {
        self.network = network
    }
    
    func load() async {
        let trimmed = city.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmed.isEmpty else {
            weather = nil
            errorMessage = "Введите город"
            return
        }
        
        await loadWeather(for: trimmed)
    }
    
    // Загрузка по названию города
    func loadWeather(for city: String) async {
        let trimmed = city.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        
        await fetch(query: trimmed)
    }
    
    // Загрузка по координатам (геолокация)
    func loadWeather(for location: CLLocation) async {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        let query = "\(lat),\(lon)"
        
        await fetch(query: query)
    }
    
    
    // Перезагрузка текущего города
    func reload() {
        Task{
            await load()
        }
    }
    
    // Core fetch logic
    
    private func fetch(query: String) async {
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false }
        
        do {
            let dto = try await network.fetchForecast(for: query)
            
            guard let mapped = WeatherMapper.map(from: dto) else {
                weather = nil
                errorMessage = "Не удалось обработать данные"
                return
            }
            
            weather = mapped
            
        } catch {
            weather = nil
            errorMessage = error.localizedDescription
        }
    }
}
