

import Foundation


struct WeatherMapper{
    static func map(from dto: WeatherResponse) -> Weather? {
        guard
            let location = dto.location,
            let current = dto.current
                else { return nil }
        
        let forecast = dto.forecast?.forecastday ?? []
        //7 days
        let daily = forecast.compactMap { dayDTO -> DailyForecast? in
                let date = dayDTO.date ?? ""
            guard let day = dayDTO.day else { return nil }
            
            return DailyForecast(date: date,
                                 maxTemp: day.maxtemp_c ?? 0,
                                 minTemp: day.mintemp_c ?? 0,
                                 description: day.condition?.text ?? "",
                                 iconURL: normolizeURL(day.condition?.icon))
        }
        
        //Hourly (только сегодня, ближайшие 12 часов, сейчас)
        let hourlyDTO = forecast.first?.hour ?? []
        let hourly = mapNext12Hours(hourlyDTO)
        
        return Weather(city: location.name ?? "", country: location.country ?? "", temperature: current.temp_c ?? 0, description: current.condition?.text ?? "", iconURL: normolizeURL(current.condition?.icon), forecast: daily, hourly: hourly)
    }
    
    private static func mapNext12Hours(_ hours: [HourDTO]) -> [HourlyForecast]{
        let now = Date()
        let calendar = Calendar.current
        
        // Парсинг времени из API: "yyyy-MM-dd HH:mm"
        let parsed: [(date : Date, dto: HourDTO)] = hours.compactMap { h in
            guard let raw = h.time, let d = parseHourDate(raw) else { return nil }
            return (d, h)
        }.sorted { $0.date < $1.date }
        
        //Старт с текущего часа
        let startHour = calendar.dateInterval(of: .hour, for: .now)?.start ?? now
        let startIndex = parsed.firstIndex(where: { $0.date >= startHour }) ?? 0
        
        let next = parsed.dropFirst(startIndex).prefix(12)
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "HH:mm"
        
        return next.map { pair in
            let dto = pair.dto
            let date = pair.date
            
            let isNow = calendar.isDate(date, equalTo: now, toGranularity: .hour)
            let label = isNow ? "Сейчас" : formatter.string(from: date)
            
            return HourlyForecast(time: label, temperature: dto.temp_c ?? 0, iconURL: normolizeURL(dto.condition?.icon), isNow: isNow)
        }
    }
    
    private static func parseHourDate(_ raw: String) -> Date? {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "yyyy-MM-dd HH:mm"
        f.timeZone = .current
        return f.date(from: raw)
    }
    private  static func normolizeURL(_ icon: String?) -> String{
        guard let icon = icon else { return "" }
        
        if icon.hasPrefix("http") {
            return icon
        }
        return "https:\(icon)"
    }
}
