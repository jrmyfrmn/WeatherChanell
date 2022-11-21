//
//  DetailScreen.swift
//  ForecastingWeather
//
//  Created by jeremy.fermin on 11/8/22.
//

import SwiftUI

struct DetailScreen: View {
    
    @State var myWeather: WeatherViewModel!
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            VStack {
                ForecastList(myWeather: myWeather)
            }//Vstack
        }//Zstack
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .navigationBarHidden(true)
    }
}
struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView()
            .environmentObject(Store())
    }
}
