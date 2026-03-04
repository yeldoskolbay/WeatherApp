

import SwiftUI

struct DailyForecastRow: View {
    let item: DailyForecast
    var body: some View {
        HStack(spacing: 12){
            Text(item.weekDayShort)
                .frame(width: 36, alignment: .leading)
                .foregroundStyle(.secondary)
            
            RemoteImage(urlString: item.iconURL)
                .frame(width: 22, height: 22)
            
            Text(item.description)
                .lineLimit(1)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            Text("\(Int(item.minTemp))")
                .foregroundStyle(.secondary)
                .frame(width: 32, alignment: .trailing)
            
            Text("\(Int(item.maxTemp))")
                .fontWeight(.semibold)
                .frame(width: 40, alignment: .trailing)
        }
        .padding(.vertical, 8)
    }
}
