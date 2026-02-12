

import Foundation


struct ForecastDayDTO: Decodable {
    let date : String?
    let day : Day?
    let hour : [HourDTO]?
}
