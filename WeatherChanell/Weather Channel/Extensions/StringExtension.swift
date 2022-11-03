//
//  StringExtension.swift
//  ForecastingWeather
//
//  Created by jeremy.fermin on 11/3/22.
//

import Foundation

extension String {
    
    func trimmedAndEscaped() -> String {
        
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
