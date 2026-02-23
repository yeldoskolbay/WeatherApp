
import Foundation

extension DailyForecast{
    var weekDayShort: String {
        let iso = ISO8601DateFormatter()
        iso.formatOptions = [.withFullDate]
        
        guard let d = iso.date(from: date) else { return date }
        
        let f = DateFormatter()
        f.locale = Locale(identifier: "ru_RU")
        f.dateFormat = "EE"
        return f.string(from: d).capitalized
    }
}
