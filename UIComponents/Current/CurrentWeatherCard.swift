
import SwiftUI

struct CurrentWeatherCard: View {
    let weather: Weather
    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 12){
                Text("\(weather.city), \(weather.country)")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.white)
                
                HStack(alignment: .center){
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(Int(weather.temperature))")
                            .font(.system(size: 64, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                        
                        Text(weather.description)
                            .font(.callout)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    RemoteImage(urlString: weather.iconURL)
                        .frame(width: 84, height: 84)
                }
            }
        }
    }
}
