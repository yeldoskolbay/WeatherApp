

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
                    Divider()
                }
            }
            .padding(.horizontal, 12)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .padding(.horizontal, 16)
    }
}
