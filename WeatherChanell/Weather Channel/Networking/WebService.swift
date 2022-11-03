//
//  WebService.swift
//  ForecastingWeather
//
//  Created by jeremy.fermin on 11/3/22.
//

import Foundation
import CoreLocation

enum NetworkErrors: Error {
    case badUrl
    case noData
    case decodingError
}

class WebService: NSObject {
    private let locationManager = CLLocationManager()
    private var dataTask: URLSessionDataTask?
    
//MARK: - Current Location
    func getCurrentCity(city: String, completion: @escaping (Result<MyWeather?, NetworkErrors>) -> Void) {
        guard let url = URL.getForecastByCity(city)
            else {
            return completion(.failure(.badUrl))
    }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            guard let forecast = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(MyWeather(forecast: forecast)))
            
        }.resume()
        }
    }

