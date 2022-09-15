//
//  API+Extensions.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 9/12/22.
//

import Foundation

extension API {
    static let baseURLSting = "https://api.openweathermap.org/data/2.5/"
    
    static func getURLFor(lat: Double, lon: Double) -> String {
        return "\(baseURLSting)onecall?lat=\(lat)&lon=\(lon)&exclude=minutely&appid=\(key)&unites=imperial"
    }
}
