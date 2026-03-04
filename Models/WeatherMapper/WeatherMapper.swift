

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
        
        let startHour = calendar.dateInterval(of: .hour, for: now)?.start ?? now
        
        // Парсинг времени из API: "yyyy-MM-dd HH:mm"
        let parser = DateFormatter()
        parser.locale = Locale(identifier: "en_US_POSIX")
        parser.dateFormat = "yyyy-MM-dd HH:mm"
        parser.timeZone = .current
        
        let parsed: [(date : Date, dto: HourDTO)] = hours.compactMap { hour in
            
            guard let raw = hour.time, let date = parser.date(from: raw)
            else { return nil }
            return (date, hour)
        }
            .sorted { $0.date < $1.date }
        
        //Старт с текущего часа
        let startIndex = parsed.firstIndex(where: { $0.date >= startHour }) ?? 0
        
        let nextHours = parsed.dropFirst(startIndex).prefix(12)
        return nextHours.map { pair in
            HourlyForecast(date: pair.date, temperature: pair.dto.temp_c ?? 0, iconURL: normolizeURL(pair.dto.condition?.icon))
        }
    }
    
    private  static func normolizeURL(_ icon: String?) -> String{
        guard let icon = icon else { return "" }
        
        if icon.hasPrefix("http") {
            return icon
        }
        return "https:\(icon)"
    }
}
