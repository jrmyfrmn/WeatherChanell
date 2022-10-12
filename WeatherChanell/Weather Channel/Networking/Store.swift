//
//  Store.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/7/22.
//

import Foundation

class Store: ObservableObject {
    
    @Published var tempUnit: TemperatureUnit = .celsius
    @Published var weatherLocList: [WeatherVM] = [WeatherVM]()
    
    init() {
        tempUnit = UserDefaults.standard.unit
    }
    
    func addWeather(_ weather: WeatherVM) {
        weatherLocList.append(weather)
    }
    
}
