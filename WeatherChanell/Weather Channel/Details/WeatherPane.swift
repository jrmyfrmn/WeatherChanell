//
//  WeatherPane.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/12/22.
//

import SwiftUI

struct WeatherPane: View {
    
    var image: String
    var value: String
    
    var body: some View {
        VStack (alignment: .center) {
            Image("\(image)")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            
            Text("\(value)")
                .fontWeight(.light)
                .font(.subheadline)
        }
    }
}

struct WeatherPane_Previews: PreviewProvider {
    static var previews: some View {
        WeatherPane(image: "Umbrella", value: "30")
    }
}
