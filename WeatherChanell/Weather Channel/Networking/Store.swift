//
//  Store.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/7/22.
//

import Foundation

class Store: ObservableObject {
    
    @Published var tempUnit: TemperatureUnit = .celsius
    @Published var weatherLocList: [WeatherViewModel] = []
    
    init() {
        tempUnit = UserDefaults.standard.unit
        print(FileManager.docDirURL.path)
        if FileManager().docExist(named: fileName) {
            loadWeather()
        }
    }
    
    func addWeather(_ weather: WeatherViewModel) {
        weatherLocList.append(weather)
        saveWeather()
    }
    
    func updateToDo(_ myWeather: WeatherViewModel) {
        guard let index = weatherLocList.firstIndex(where: { $0.id == myWeather.id}) else { return }
        weatherLocList[index] = myWeather
        saveWeather()
    }
    
    func deleteToDo(at indexSet: IndexSet) {
        weatherLocList.remove(atOffsets: indexSet)
        saveWeather()
    }
    
    func loadWeather() {
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    weatherLocList = try decoder.decode([WeatherViewModel].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveWeather() {
        print("Saving toDos to file system")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(weatherLocList)
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
