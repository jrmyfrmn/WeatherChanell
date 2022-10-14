//
//  Weather.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 9/12/22.
//

import Foundation

struct CityName: Codable, Identifiable {
    var name: String
    var country: String
    var id: UUID {
        UUID()
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case country = "country"
    }
    
    init() {
        name = ""
        country = ""
    }
}

struct WeatherList: Codable, Identifiable {
    var date: Int
    var main: Main
    var weather: [Weather]
    var wind: Wind
    var pop: Double
    var id: UUID {
        UUID()
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main = "main"
        case weather = "weather"
        case wind = "wind"
        case pop = "pop"
    }
    
    init() {
        date = 0
        main = Main(temp: 0.0, humidity: 0)
        weather = []
        wind = Wind(speed: 0.0)
        pop = 0
    }
}

struct Main: Codable {
    var temp: Double
    var humidity: Int
}

struct Weather: Codable, Identifiable {
    var main: String
    var description: String
    var icon: String
    var id: Int {
        0
    }
}

struct Wind: Codable {
    var speed: Double
}

struct WeatherResponse: Codable {
    var city: CityName
    var list: [WeatherList]
    
    static func empty() -> WeatherResponse {
        WeatherResponse(
            city: CityName(),
            list: [WeatherList](repeating: WeatherList(), count: 40)
        )
    }
}

