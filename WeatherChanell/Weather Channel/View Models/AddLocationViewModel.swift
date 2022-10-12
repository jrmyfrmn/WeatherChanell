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


