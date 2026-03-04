

import SwiftUI

struct HourlyForecastSection: View {
    let items: [HourlyForecast]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Сегодня по часам")
                .font(.headline)
            Divider()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10){
                    ForEach(items) { item in
                        HourlyForecastCell(item: item)
                    }
                }
                .padding(.horizontal, 12)
            }
        }
        .padding(12)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
    }
}




