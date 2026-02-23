

import SwiftUI


struct HourlyForecastCell: View {
    let item: HourlyForecast
    var body: some View {
        VStack(spacing: 8) {
            Text(item.time)
                .font(.subheadline)
                .fontWeight(item.isNow ? .semibold : .regular)
                .foregroundStyle(item.isNow ? .primary : .secondary)
            
            RemoteImage(urlString: item.iconURL)
                .frame(width: 32, height: 32)
            
            Text("\(Int(round(item.temperature)))")
                .font(.headline)
        }
        .frame(width: 75)
        .padding(.vertical, 12)
        .background(.thinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(.primary.opacity(0.35), lineWidth: 1)
                .opacity(item.isNow ? 1 : 0)
        )
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

