//
//  Weather_ChannelApp.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 9/12/22.
//


import SwiftUI

@main
struct ForecastingWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let currentCityVM = CurrentCityViewModel(weatherService: WeatherService())
            SplashScreenView()
               .environmentObject(Store())
        }
    }
}
