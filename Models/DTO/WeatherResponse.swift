

import Foundation


struct WeatherResponse: Decodable {
    let location: Location
    let current: Current
    let forecast: Forecast
}

struct Location: Decodable {
    let name: String
    let country: String
    let localTime: String
}


struct Current: Decodable {
    let temp_c: Double
    let condition: Condition
}


struct Condition: Decodable {
    let text: String
    let icon: String
}


struct Forecast: Decodable {
    let forecastday: [Forecastday]
}


struct Forecastday: Decodable {
    let date : String
    let day : Day
}


struct Day: Decodable {
    let maxtemp_c : Double
    let mintemp_c : Double
    let condition : Condition
}
