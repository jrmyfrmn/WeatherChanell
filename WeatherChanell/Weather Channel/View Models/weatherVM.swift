//
//  weatherVM.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/11/22.
//

import Foundation
import Foundation
import CoreLocation
import SwiftUI

final class WeatherVM: ObservableObject {
    
    //MARK: - PROPERTIES
    
    let id = UUID()
    
    @EnvironmentObject var store: Store
    
    @Published var weather = WeatherResponse.empty()
    
    @Published var city = Constants.Strings.city {
        didSet {
            getLocation()
        }
    }
    
    //MARK: - GEOCODE
    
    init() {
        getLocation()
    }
    
    
    func getLocation() {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks,
               let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    func getWeather(coord: CLLocationCoordinate2D?) {
        
        var urlString = ""
        if let coord = coord {
            urlString = weatherAPI.getURLWeather(latitude: coord.latitude, longitude: coord.longitude)
        } else {
            urlString = weatherAPI.getURLWeather(latitude: 14.284, longitude: 121.08889) // Santa Rosa
        }
        getWeatherInternal(city: city, for: urlString)
    }
    
    func getWeatherInternal(city: String, for urlString: String) {
        guard let url = URL(string: urlString) else {return}
        NetworkManager<WeatherResponse>.fetchWeather(for: url) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather = response
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - CURRENT
    
    var currentLocation: String {
        return weather.city.name
    }
    
    var currentCountry: String {
        return weather.city.country
    }
    
    var currentDate: String {
        return Time.defaultDateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval((weather.list.first?.date)!) ))
    }
    
    var currentWeatherIcon: String? {
        return dailyWeatherIcons.first
    }
    
    var currentTemp: String? {
        return getTempByUnit(unit: store.tempUnit)[0]
    }
    
    var currentCondition: String? {
        return dailyConditions.first
    }
    
    var currentHumidity: Int {
        return weather.list.first?.main.humidity ?? 0
    }
    
    var currentWind: String {
        return roundedOf(weather.list.first?.wind.speed ?? 0.0)
    }
    
    var currentRain: String {
        return toString(100*(weather.list.first?.pop ?? 0.0))
    }
    
    //MARK: - DAY
    
    var dailyDays: [String] {
        return [ Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[0].date ))),
                 Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[7].date ))),
                 Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[15].date ))),
                 Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[23].date ))),
                 Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[31].date ))),
                 Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[39].date )))
        ]
    }
    
    //MARK: - DATE
    
    var dailyDates: [String] {
        return [ Time.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[0].date ))),
                 Time.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[7].date ))),
                 Time.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[15].date ))),
                 Time.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[23].date ))),
                 Time.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[31].date ))),
                 Time.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[39].date )))
        ]
    }
    
    //MARK: - TEMPERATURE
    
    func getTempByUnit(unit: TemperatureUnit) -> [String] {
        switch unit {
        case .celsius:
            return [ roundedOf(weather.list[0].main.temp),
                     roundedOf(weather.list[7].main.temp),
                     roundedOf(weather.list[15].main.temp),
                     roundedOf(weather.list[23].main.temp),
                     roundedOf(weather.list[31].main.temp),
                     roundedOf(weather.list[39].main.temp)
            ]
        case .fahrenheit:
            return [ roundedOf(1.8 * (weather.list[0].main.temp) + 32),
                     roundedOf(1.8 * (weather.list[7].main.temp) + 32),
                     roundedOf(1.8 * (weather.list[15].main.temp) + 32),
                     roundedOf(1.8 * (weather.list[23].main.temp) + 32),
                     roundedOf(1.8 * (weather.list[31].main.temp) + 32),
                     roundedOf(1.8 * (weather.list[39].main.temp) + 32)
            ]
        }
    }
    
    //MARK: - CONDITION
    
    var dailyConditions: [String] {
        return [ weather.list[0].weather.first?.description ?? "Sunny",
                 weather.list[7].weather.first?.description ?? "Sunny",
                 weather.list[15].weather.first?.description ?? "Sunny",
                 weather.list[23].weather.first?.description ?? "Sunny",
                 weather.list[31].weather.first?.description ?? "Sunny",
                 weather.list[39].weather.first?.description ?? "Sunny"
        ]
    }
    
    //MARK: - WEATHER ICON
    
    var dailyWeatherIcons: [String] {
        return [ weather.list[0].weather.first?.icon ?? "",
                 weather.list[7].weather.first?.icon ?? "",
                 weather.list[15].weather.first?.icon ?? "",
                 weather.list[23].weather.first?.icon ?? "",
                 weather.list[31].weather.first?.icon ?? "",
                 weather.list[39].weather.first?.icon ?? ""
        ]
    }
    
    //MARK: - FUNCTIONS
    
    func toString(_ double: Double) -> String {
        return String(format: "%1.f", double)
    }
    
    func roundedOf(_ roundOf: Double) -> String {
        return String(format: "%.1f", roundOf)
    }
    
    func getWeatherIconFor(icon: String) -> Image {
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
