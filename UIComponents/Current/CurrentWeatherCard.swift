
import SwiftUI

struct CurrentWeatherCard: View {
    let weather: Weather
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("\(weather.city), \(weather.country)")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.primary)
            
            HStack(){
                RemoteImage(urlString: weather.iconURL)
                    .frame(width: 52, height: 52)
                
                Text("\(Int(weather.temperature))")
                    .font(.system(size: 56, weight: .bold))
                
                Spacer()
            }
            
            Text(weather.description)
                .foregroundStyle(.secondary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
