

import Foundation


struct WeatherMapper{
    static func map(from dto: WeatherResponse) -> Weather? {
        guard
            let location = dto.location,
            let current = dto.current,
            let forecast = dto.forecast?.forecastday
                else { return nil }
        
        //7 days
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
            
            return DailyForecast(date: date, maxTemp: max, minTemp: min, description: text, iconURL: normolizeURL(icon))
        }
        let hourlyDTO = forecast.first?.hour ?? []
        let hourly = hourlyDTO.compactMap { hourDTO -> HourlyForecast? in
            guard
                let time = hourDTO.time,
                let temp = hourDTO.temp_c,
                let icon = hourDTO.condition?.icon
            else { return nil }
            
            return HourlyForecast(time: time, temperature: temp, iconURL: normolizeURL(icon))
        }
        return Weather(city: location.name ?? "", country: location.country ?? "", temperature: current.temp_c ?? 0, description: current.condition?.text ?? "", iconURL: normolizeURL(current.condition?.icon), forecast: daily, hourly: hourly)
    }
    
    private  static func normolizeURL(_ icon: String?) -> String{
        guard let icon = icon else { return "" }
        
        if icon.hasPrefix("http") {
            return icon
        }
        return "https:\(icon)"
    }
}
