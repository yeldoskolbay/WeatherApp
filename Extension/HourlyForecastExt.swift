

import Foundation


extension HourlyForecast {
    var hourText: String {
        if isCurrentHour { return "Сейчас" }
        let f = DateFormatter()
        f.locale = Locale(identifier: "ru_RU")
        f.dateFormat = "HH:mm"
        return f.string(from: date)
    }
    
    var isCurrentHour: Bool {
        Calendar.current.isDate(date, equalTo: Date(), toGranularity: .hour)
    }
}
