//
//  CurrentWeather.swift
//  ForecastingWeather
//
//  Created by jeremy.fermin on 11/17/22.
//

import Foundation

public struct CurrentCityWeather {
    
    let city: String
    let temperature: String
    let description: String
    let iconName: String
    
    init (response: APIResponse) {
        
        city = response.name
        temperature = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
    }
}
