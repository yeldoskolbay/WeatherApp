

import Foundation


struct WeatherMapper{
    static func map(from dto: WeatherResponse) -> Weather? {
        guard
            let location = dto.location,
            let current = dto.current,
            let forecast = dto.forecast?.forecastday
                else { return nil }
        
        let daily = forecast.compactMap { dayDTO -> DailyForecast? in
            guard
                let date = dayDTO.date,
                let day = dayDTO.day,
                let max = day.maxtemp_c,
                let min = day.mintemp_c,
                let condition = day.condition,
                let text = condition.text,
                let icon = condition.icon
                    else { return nil }
            
            return DailyForecast(date: date, maxTemp: max, minTemp: min, description: text, iconURL: "https: \(icon)")
            
        }
        return Weather(city: location.name ?? "", country: location.country ?? "", temperature: current.temp_c ?? 0, description: current.condition?.text ?? "", iconURL: "https: \(current.condition?.icon ?? "")", forecast: daily)
    }
}
