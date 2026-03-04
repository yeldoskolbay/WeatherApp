

import SwiftUI


struct HourlyForecastCell: View {
    let item: HourlyForecast
    var body: some View {
        VStack(spacing: 8) {
            Text(item.hourText)
                .font(.subheadline)
                .fontWeight(item.isCurrentHour ? .semibold : .regular)
                .foregroundStyle(item.isCurrentHour ? .primary : .secondary)
            
            RemoteImage(urlString: item.iconURL)
                .frame(width: 28, height: 28)
            
            Text("\(Int(round(item.temperature)))")
                .font(.headline)
        }
        .frame(width: 74, height: 110)
        .background(item.isCurrentHour ? .ultraThinMaterial : .thinMaterial)
        .overlay{
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(item.isCurrentHour ? Color.primary.opacity(0.35) : Color.clear, lineWidth: 1)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

