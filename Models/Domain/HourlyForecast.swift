

import Foundation


struct HourlyForecast: Identifiable {
    let id = UUID()
    let time: String
    let temperature: Double
    let iconURL: String
    let isNow: Bool
}
