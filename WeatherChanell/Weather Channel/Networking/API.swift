//
//  API.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 9/12/22.
//

import Foundation

struct weatherAPI {
    static func getURLWeather(latitude: Double, longitude: Double) -> String {
        return "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=a52c26db8c744d5a2440ed25440f238e&units=metric"
    }
}

final class NetworkManager<T: Codable> {
    static func fetchWeather(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard error == nil else {
                print(String(describing: error))
                if let error = error?.localizedDescription {
                    completion(.failure(.error(err: error)))
                }
                return
            }
            
            do {
                let json = try JSONDecoder().decode(T.self, from: data)
                completion(.success(json))
            } catch let err {
                print(String(describing: err))
                completion(.failure(.decodingError(err: err.localizedDescription)))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case decodingError(err: String)
    case error(err: String)
}

extension URL {
    
    static func getForecastByCity(_ city: String) -> URL? {
        
        return URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=96d28c208664698f6c02c4be0dba3e8f&units=metric")
    }
}
