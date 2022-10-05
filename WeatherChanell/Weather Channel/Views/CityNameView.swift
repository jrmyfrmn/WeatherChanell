//
//  CityNameView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 9/15/22.
//

import SwiftUI

struct CityNameView: View {
    var city: String
    var date: String
    
    var body: some View {
        HStack {
            VStack(alignment: .center, spacing: 10) {
                Text(city)
                    .font(.title)
                    .bold()
                Text(date)
            }.foregroundColor(.white)
        }
    }
}

struct CityNameView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDisplayName("LightMode")
                .preferredColorScheme(.light)
            ContentView()
                .previewDisplayName("DarkMode")
                .preferredColorScheme(.dark)
        }
    }
}
