

import SwiftUI

struct HourlyForecastSection: View {
    let items: [HourlyForecast]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Сегодня по часам")
                .font(.headline)
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12){
                    ForEach(items) { item in
                        HourlyForecastCell(item: item)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }
        }
    }
}




