//
//  DetailedViewModel.swift
//  ForecastingWeather
//
//  Created by jeremy.fermin on 11/8/22.
//

import Foundation
import SwiftUI


enum LoadingState {
    case loading
    case success
    case failed
    case none
}

class DetailedViewModel: ObservableObject {
    @Published var loadingState: LoadingState = .none
    @Published var myWeather: MyWeather?
    let webService = WebService()
    var city: String = ""
    
    init (myWeather: MyWeather? = nil) {
        self.myWeather = myWeather
    }
    
    let id = UUID()
    
    func getByCity(city: String) {
        webService.getCurrentCity(city: city.trimmedAndEscaped()) { result in
            switch result {
                case .success(let myWeather):
                if let myWeather = myWeather {
                    DispatchQueue.main.async {
                        self.myWeather = myWeather
                        self.loadingState = .success
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.loadingState = .failed
            }
        }//webService
    }//end func

    var cityName: String {
        return myWeather!.city
    }
    var description: String {
        return myWeather!.description0
    }
    var currentWind: String {
        return roundedOf(myWeather!.speed)
    }
    var icon: String {
        return myWeather!.icon0
    }

    func getTempUnit (unit: TemperatureUnit) -> [String] {
        switch unit {
            case .celsius:
            return
            [
                roundedOf(myWeather!.temperature0),
                roundedOf(myWeather!.temperature1),
                roundedOf(myWeather!.temperature2),
                roundedOf(myWeather!.temperature3),
                roundedOf(myWeather!.temperature4)
            ]
            case .fahrenheit:
            return
            [
                roundedOf(1.8 * (myWeather!.temperature0) + 32),
                roundedOf(1.8 * (myWeather!.temperature1) + 32),
                roundedOf(1.8 * (myWeather!.temperature2) + 32),
                roundedOf(1.8 * (myWeather!.temperature3) + 32),
                roundedOf(1.8 * (myWeather!.temperature4) + 32)
            ]
        }
    }
    
    func roundedOf(_ roundOf: Double) -> String {
        return String(format: "%.0f", roundOf)
    }
    
    var detailedWeatherIcons: [String] {
        return
        [
            myWeather!.icon0,
            myWeather!.icon1,
            myWeather!.icon2,
            myWeather!.icon3,
            myWeather!.icon4
        ]
    }
    
    func getWeatherIconForDetailed(detailedIcon: String) -> Image {
        switch detailedIcon {
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
}// end class



