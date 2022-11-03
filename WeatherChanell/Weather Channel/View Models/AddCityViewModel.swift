//
//  AddCityViewModel.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 11/3/22.
//

import Foundation
import CoreData
import SwiftUI

class AddCityViewModel: ObservableObject {
    var city: String = ""
    
    func getCity(completion: @escaping (WeatherViewModel) -> Void ) {
        WebService().getCurrentCity(city: city.trimmedAndEscaped()) { result  in
            switch result {
            case .success(let myWeather):
                DispatchQueue.main.async {
                    completion(WeatherViewModel(myWeather: myWeather!))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct WeatherViewModel: Identifiable, Codable {
    let myWeather: MyWeather
    var id = UUID()
    
    var cityName: String {
        return myWeather.city
    }
    var temp: String {
        return getTempByUnit(unit: Store().tempUnit)
    }
    var icon: String {
        return myWeather.icon0
    }
    var description: String {
        return myWeather.description0
    }
    
    func getTempByUnit(unit: TemperatureUnit) -> String {
        switch unit {
            case .celsius:
            return roundedOf(myWeather.temperature0)
        case .fahrenheit:
            return roundedOf(1.8 * (myWeather.temperature0) + 32)
        }
    }

    func roundedOf(_ roundOf: Double) -> String {
        return String(format: "%.0f", roundOf)
    }

    func getWeatherIconForCity(icon: String) -> Image {
        switch icon {
        case "01d":
            return Image("sun")
        case "01n":
            return Image("moon")
        case "02d":
            return Image("cloudSun")
        case "02n":
            return Image("cloudMoon")
        case "03d":
            return Image("cloud")
        case "03n":
            return Image("cloudMoon")
        case "04d":
            return Image("cloudMax")
        case "04n":
            return Image("cloudMoon")
        case "09d":
            return Image("rainy")
        case "09n":
            return Image("rainy")
        case "10d":
            return Image("rainySun")
        case "10n":
            return Image("rainyMoon")
        case "11d":
            return Image("thunderstormSun")
        case "11n":
            return Image("thunderstormMoon")
        case "13d":
            return Image("snowy")
        case "13n":
            return Image("snowy-2")
        case "50d":
            return Image("tornado")
        case "50n":
            return Image("tornado")
        default:
            return Image("sun")
        }
    }    
}
