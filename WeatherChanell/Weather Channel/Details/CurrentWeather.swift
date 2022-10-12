//
//  CurrentWeather.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/12/22.
//

import SwiftUI

struct CurrentWeather: View {
    
    @ObservedObject var weatherVM = WeatherVM()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack (alignment: .center) {
            HStack (alignment: .center) {
                Spacer()
                weatherVM.getWeatherIconFor(icon: weatherVM.dailyWeatherIcons[0])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100, alignment: .trailing)
                
                Spacer()
                VStack (alignment: .trailing) {
                    Text("\(weatherVM.getTempByUnit(unit: store.tempUnit)[0]) °\(String(store.tempUnit.displayText.prefix(1)))")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    
                    Text("\(weatherVM.dailyConditions[0].uppercased())")
                        .fontWeight(.light)
                        .font(.title3)
                }
                Spacer()
            }.padding()
            
            HStack {
                WeatherPane(image: "wind", value: "\(weatherVM.currentWind) m/s")
                    .padding(.horizontal)
                
                WeatherPane(image: "humidity", value: "\(weatherVM.currentHumidity) %")
                    .padding(.horizontal)
                
                WeatherPane(image: "umbrella", value: "\(weatherVM.currentRain) %")
                    .padding(.horizontal)
                
            }.padding()
            
        }
        .foregroundColor(Color("TextColor"))
        .background(
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color("ThemeColor"))
                .frame(width: 350, height: 250)
        )
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct CurrentWeather_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeather()
            .previewLayout(.sizeThatFits)
            .environmentObject(Store())
    }
}
