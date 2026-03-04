

import SwiftUI


struct WeatherBackground: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color(red: 0.10, green: 0.12, blue: 0.20),
                Color(red: 0.35, green: 0.15, blue: 0.55),
                Color(red: 0.10, green: 0.12, blue: 0.20),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
        .overlay(
            RadialGradient(
                colors: [Color.white.opacity(0.10), .clear],
                center: .topTrailing,
                startRadius: 10,
                endRadius: 420
            )
            .ignoresSafeArea()
        )
    }
}
