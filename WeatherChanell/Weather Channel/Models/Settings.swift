//
//  Settings.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/12/22.
//

import Foundation

enum TemperatureUnit: String, CaseIterable, Identifiable {
    
    var id: String {
        return rawValue
    }
    case celsius
    case fahrenheit
}

extension TemperatureUnit {
    
    var displayText: String {
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        }
    }
}

enum Sheets: Identifiable {
    
    var id: UUID {
        return UUID()
    }
    
    case settings
}



