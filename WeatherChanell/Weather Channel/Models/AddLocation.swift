//
//  AddLocation.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/12/22.
//

import Foundation

struct AddLocation: Identifiable, Codable {
    
    var id: String = UUID().uuidString
    var location: String
    
    static var sampleData: [AddLocation] {
        [
            AddLocation(location: "Makati")
        ]
    }
}
