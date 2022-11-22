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
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Today's Weather")
                    .bold()
                    .foregroundColor(Color("TextColor"))
                
                Spacer()
                                
                NavigationLink(destination: Next5DaysView(), label: {
                    
                    Text("Next 5 Days")
                        .bold()
                        .foregroundColor(Color("TextColor"))
                    
                    Image(systemName: "chevron.right.circle.fill")
                        .foregroundColor(Color("TextColor"))
                    
                })
                .navigationTitle("")
                
            }
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .padding(10)
        .foregroundColor(Color("TextColor"))
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
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
