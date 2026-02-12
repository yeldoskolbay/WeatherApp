

import Foundation


struct HourDTO: Decodable{
    let time: String?
    let temp_c: Double?
    let condition: Condition?
}
