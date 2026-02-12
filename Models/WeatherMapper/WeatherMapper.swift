

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
            
            return DailyForecast(date: date, maxTemp: day.maxtemp_c ?? 0, minTemp: day.mintemp_c ?? 0, description: day.condition?.text ?? "", iconURL: normolizeURL(day.condition?.icon))
        }
        
        let hourlyDTO = forecast.first?.hour ?? []
        let hourly = hourlyDTO.compactMap { hourDTO -> HourlyForecast? in
            guard let time = hourDTO.time else { return nil }

            return HourlyForecast(time: time, temperature: hourDTO.temp_c ?? 0, iconURL: normolizeURL(hourDTO.condition?.icon))
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
