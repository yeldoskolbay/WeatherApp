

import Foundation


struct ForecastDay: Decodable {
    let date : String?
    let day : Day?
    let hour : [Hour]?
}
