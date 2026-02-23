

import SwiftUI


struct HourlyForecastCell: View {
    let item: HourlyForecast
    var body: some View {
        VStack(spacing: 8){
            Text(shortTime(item.time))
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
            RemoteImage(urlString: item.iconURL)
                .frame(width: 32, height: 32)
            
            Text("\(Int(round(item.temperature)))")
                .font(.headline)
        }
        .frame(width: 75)
        .padding(.vertical, 12)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
    
    
    private func shortTime(_ raw: String) -> String {
        let parts = raw.split(separator: "")
        return parts.count == 2 ? String(parts[1]) : raw
    }
}
