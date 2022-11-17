//
//  CurrentLocation.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/12/22.
//

import SwiftUI

struct CurrentLocation: View {

    @AppStorage("isDarkMode") private var isDarkMode = false
    @ObservedObject var weatherVM = WeatherVM()
    @ObservedObject var currentCityVM = CurrentCityViewModel(weatherService: WeatherService())
    
    var body: some View {
        VStack {
            Text(currentCityVM.cityName)
                .font(.largeTitle)
                .fontWeight(.heavy)
            
            Text("\(weatherVM.currentDate)")
        }
        .onAppear(perform: currentCityVM.refresh)
        .foregroundColor(Color("TextColor"))
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct CurrentLocation_Previews: PreviewProvider {
    static var previews: some View {
        CurrentLocation(currentCityVM: CurrentCityViewModel(weatherService: WeatherService()))
            .previewLayout(.sizeThatFits)
    }
}
