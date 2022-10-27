//
//  AddLocationViewModel.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/11/22.
//

import Foundation

class AddLocationViewModel: ObservableObject {
    
    var location: String = ""
    var id: String?
    var updating: Bool {
        id != nil
    }
    
    var isDisabled: Bool {
        location.isEmpty
    }
    
    init() {}
    
    init(_ currentLocation: AddLocation) {
        self.location = currentLocation.location
        id = currentLocation.id
    }
}

class DataStore: ObservableObject {
    @Published var loc:[AddLocation] = []
    
    init() {
        print(FileManager.docDirURL.path)
        if FileManager().docExist(named: fileName){
            loadToDos()
        }
    }
    
    func addLocation(_ location: AddLocation) {
        loc.append(location)
        saveLocation()
    }
    
    func updateLocation(_ location: AddLocation) {
        guard let index = loc.firstIndex(where: { $0.id == location.id}) else { return }
        loc[index] = location
        saveLocation()
    }
    
    func deleteLocation(at indexSet: IndexSet) {
        loc.remove(atOffsets: indexSet)
        saveLocation()
    }
    
    func loadToDos() {
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    loc = try decoder.decode([AddLocation].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveLocation() {
        print("Saving Location to file system")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(loc)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ForecastViewModel: Identifiable, Codable {
    
    
    let weather: WeatherResponse
    var id = UUID()
    
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
        return getTempByUnit(unit: .celsius)[0]
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
    
    var dailyDays: [String] {
        return [ Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[0].date ))),
                 Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[7].date ))),
                 Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[15].date ))),
                 Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[23].date ))),
                 Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[31].date ))),
                 Time.dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[39].date )))
        ]
    }
    
    var dailyDates: [String] {
        return [ Time.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[0].date ))),
                 Time.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[7].date ))),
                 Time.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[15].date ))),
                 Time.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[23].date ))),
                 Time.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[31].date ))),
                 Time.dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.list[39].date )))
        ]
    }
    
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
    
    var dailyConditions: [String] {
        return [ weather.list[0].weather.first?.description ?? "Sunny",
                 weather.list[7].weather.first?.description ?? "Sunny",
                 weather.list[15].weather.first?.description ?? "Sunny",
                 weather.list[23].weather.first?.description ?? "Sunny",
                 weather.list[31].weather.first?.description ?? "Sunny",
                 weather.list[39].weather.first?.description ?? "Sunny"
        ]
    }
    
    var dailyWeatherIcons: [String] {
        return [ weather.list[0].weather.first?.icon ?? "",
                 weather.list[7].weather.first?.icon ?? "",
                 weather.list[15].weather.first?.icon ?? "",
                 weather.list[23].weather.first?.icon ?? "",
                 weather.list[31].weather.first?.icon ?? "",
                 weather.list[39].weather.first?.icon ?? ""
        ]
    }
    
    
    func toString(_ double: Double) -> String {
        return String(format: "%1.f", double)
    }
    
    func roundedOf(_ roundOf: Double) -> String {
        return String(format: "%.1f", roundOf)
    }
    
    func getWeatherIconFor(icon: String) -> String {
        switch icon {
        case "01d":
            return String("sun")
        case "01n":
            return String("moon")
        case "02d":
            return String("cloudSun")
        case "02n":
            return String("cloudMoon")
        case "03d":
            return String("cloud")
        case "03n":
            return String("cloudMoon")
        case "04d":
            return String("cloudMax")
        case "04n":
            return String("cloudMoon")
        case "09d":
            return String("rainy")
        case "09n":
            return String("rainy")
        case "10d":
            return String("rainySun")
        case "10n":
            return String("rainyMoon")
        case "11d":
            return String("thunderstormSun")
        case "11n":
            return String("thunderstormMoon")
        case "13d":
            return String("snowy")
        case "13n":
            return String("snowy-2")
        case "50d":
            return String("tornado")
        case "50n":
            return String("tornado")
        default:
            return String("sun")
        }
    }
}

