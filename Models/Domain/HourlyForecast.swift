

import Foundation


struct HourlyForecast: Identifiable {
    let id = UUID()
    let date: Date
    let temperature: Double
    let iconURL: String
}



