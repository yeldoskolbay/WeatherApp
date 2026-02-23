
import Foundation


struct DailyForecast: Identifiable{
    var id : String { date }
    
    let date: String
    let maxTemp: Double
    let minTemp: Double
    let description: String
    let iconURL: String
}
