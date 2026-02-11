//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Eldos Kolbay on 11.02.2026.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    private let network = WeatherNetworkManager()
    var body: some Scene {
        WindowGroup {
            Text("WeatherApp")
                .task {
                    await testNetwork()
                }
        }
    }
    private func testNetwork() async {
        do {
            let response = try await network.fetchForecast(for: "Almaty")
            print("Город", response.location?.name ?? "")
            print("Температура", response.current?.temp_c ?? "")
            print("Дней в прогнозе", response.forecast?.forecastday?.count ?? "")
        } catch {
            print("ошибка", error.localizedDescription)
        }
    }
}
