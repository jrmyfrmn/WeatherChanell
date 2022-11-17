//
//  WeatherService.swift
//  ForecastingWeather
//
//  Created by jeremy.fermin on 11/17/22.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject {
    
    private let locationManager = CLLocationManager()
    private let API_Key = "a52c26db8c744d5a2440ed25440f238e"
    private var completionHandler: ((CurrentCityWeather) -> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completionHandler: @escaping ((CurrentCityWeather) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // "https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}"
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_Key)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(CurrentCityWeather(response: response))
            }
        } .resume()
    }
}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations:[CLLocation]
    ) {
        guard let location = locations.first else { return }
        makeDataRequest(forCoordinates: location.coordinate)
    }
    public func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Something went wrong: \(error.localizedDescription)")
    }
}

struct APIResponse: Decodable {
    
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}

struct APIMain: Decodable {
    
    let temp: Double
}

struct APIWeather: Decodable {
    
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}

