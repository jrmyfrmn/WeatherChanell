////
////  NetworkManager.swift
////  Weather Channel
////
////  Created by jeremy.fermin on 9/12/22.
////
//
//import Foundation
//import CoreLocation
//
//class NetworkManager {
//    
//    func fetch(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherResponse {
//        
//        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&appid=a52c26db8c744d5a2440ed25440f238e&units=imperial") else { fatalError("Missing URL") }
//        
//        
//        let urlRequest = URLRequest(url: url)
//        
//        let (data, response) = try await URLSession.shared.data(for: urlRequest)
//        
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
//        
//        let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
//        
//        return decodedData
//    }
//}
////final class NetworkManager<T: Codable> {
////
////    static func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
////
////        URLSession.shared.dataTask(with: url) { (data, response, error) in
////            guard error == nil else {
////                print(String(describing: error))
////                completion(.failure(.error(err: error!.localizedDescription)))
////                return
////            }
////
////            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
////                completion(.failure(.invalidResponse))
////                return
////            }
////
////            guard let data = data else {
////                completion(.failure(.invalidData))
////                return
////            }
////
////            do {
////                let json = try JSONDecoder().decode(T.self, from: data)
////                completion(.success(json))
////            } catch let err {
////                print(String(describing: err))
////                completion(.failure(.decodingError(err: err.localizedDescription)))
////            }
////
////        }.resume()
////    }
////}
//
//enum NetworkError: Error {
//    case invalidResponse
//    case invalidData
//    case error(err: String)
//    case decodingError(err: String)
//}
