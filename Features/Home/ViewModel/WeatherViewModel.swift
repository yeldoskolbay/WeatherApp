
import Foundation


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
    
    func loadWeather(for city: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let dto = try await network.fetchForecast(for: city)
            
            guard let mapped = WeatherMapper.map(from: dto) else {
                weather = nil
                errorMessage = "Не удалось обработать данные"
                isLoading = false
                return
            }
            
            weather = mapped
            
        } catch {
            weather = nil
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func reload() {
        await load()
    }
}
