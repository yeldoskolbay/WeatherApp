
import Foundation


@MainActor

final class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let network: WeatherNetworkManager
    
    init(network: WeatherNetworkManager = WeatherNetworkManager()) {
        self.network = network
    }
    
    func loadWeather(for city: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let dto = try await network.fetchForecast(for: city)
            guard let mapped = WeatherMapper.map(from: dto) else {
                errorMessage = "Не удалось обработать данные"
                isLoading = false
                return
            }
            
            weather = mapped
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
