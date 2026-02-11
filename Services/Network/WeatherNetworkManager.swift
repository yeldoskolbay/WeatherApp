

import Foundation


final class WeatherNetworkManager {
    
    func fetchForecast(for query: String) async throws -> WeatherResponse {
        guard var components = URLComponents(string: API.baseURL + "/forecast.json") else {
            throw URLError(.badURL)
        }
        components.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "key", value: API.apiKey),
            URLQueryItem(name: "days", value: "7"),
            URLQueryItem(name: "lang", value: "ru")
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard 200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        return decoded
    }
}
