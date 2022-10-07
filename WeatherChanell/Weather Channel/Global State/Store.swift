//
//  Store.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/7/22.
//

import Foundation

class Store: ObservableObject {
    
    @Published var selectedUnit: TemperatureUnit = .kelvin
    @Published var weatherList: [CityViewViewModel] = [CityViewViewModel]()
    
    func addWeather(_ weather: CityViewViewModel) {
        weatherList.append(weather)
    }
    
}


