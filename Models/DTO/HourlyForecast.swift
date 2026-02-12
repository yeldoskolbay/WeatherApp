

import Foundation


struct HourlyForecast: Decodable {
    let time: String
    let temperature: Double
    let iconURL: String
}
