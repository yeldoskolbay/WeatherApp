

import SwiftUI

struct DailyForecastSection: View {
    let items: [DailyForecast]
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Прогноз на 7 дней")
                .font(.headline)
            
            VStack{
                ForEach(items) { item in
                DailyForecastRow(item: item)
                        .padding(.vertical, 6)
                    Divider()
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .padding(.horizontal, 16)
    }
}
