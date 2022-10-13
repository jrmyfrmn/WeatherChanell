//
//  CurrentLocation.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/12/22.
//

import SwiftUI

struct CurrentLocation: View {

    @ObservedObject var weatherVM = WeatherVM()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack {
            Text("\(weatherVM.city)")
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("\(weatherVM.currentDate)")
        }
        //.foregroundColor(Color("TextColor"))
        .foregroundColor(.white)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct CurrentLocation_Previews: PreviewProvider {
    static var previews: some View {
        CurrentLocation()
            .previewLayout(.sizeThatFits)
    }
}
