

import Foundation


struct ForecastDTO: Decodable {
    let forecastday: [ForecastDayDTO]?
}
