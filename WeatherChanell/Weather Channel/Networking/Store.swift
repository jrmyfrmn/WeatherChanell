//
//  Store.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/7/22.
//

import Foundation

class Store: ObservableObject {
    
    @Published var tempUnit: TemperatureUnit = .celsius
    @Published var weatherLocList: [ForecastViewModel] = []
    @Published var currentW: [ForecastViewModel] = []
    
    init() {
        tempUnit = UserDefaults.standard.unit
    }
    
    func addWeather(_ weather: ForecastViewModel) {
        weatherLocList.append(weather)
    }
    
    func updateToDo(_ myWeather: ForecastViewModel) {
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
                    weatherLocList = try decoder.decode([ForecastViewModel].self, from: data)
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
    
    // MARK: - Current

    func addCurrent(_ myWeather: ForecastViewModel) {
        currentW.append(myWeather)
        saveCurrent()
    }
    
    func updateCurrent(_ myWeather: ForecastViewModel) {
        guard let index = currentW.firstIndex(where: { $0.id == myWeather.id}) else { return }
        currentW[index] = myWeather
        saveCurrent()
    }
    
    func deleteCurrent(at indexSet: IndexSet) {
        currentW.remove(atOffsets: indexSet)
        saveCurrent()
    }
    
    func loadCurrent() {
        FileManager().readDocument(docName: currentFile) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    currentW = try decoder.decode([ForecastViewModel].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveCurrent() {
        print("Saving currentW to file system")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(currentW)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: currentFile) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}



