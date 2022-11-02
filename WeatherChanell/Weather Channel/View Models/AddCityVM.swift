//
//  AddCityVM.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 11/2/22.
//

import Foundation



class AddCityVM: ObservableObject {

    var city: String = ""

    func save(completion: @escaping (AddCityVM) -> Void) {

        NetworkManager().fetchWeather(city: city) { (result) in

            switch result {
            case.success(let weather):

                DispatchQueue.main.async {

                completion(AddCityVM(weather: weather))

            }

            case.failure(let error):

                print(error)

            }

        }

        

        

    }

}
