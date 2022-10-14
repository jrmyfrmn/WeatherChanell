//
//  WeatherDay.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/12/22.
//

import SwiftUI

struct WeatherDay: View {
    
    @ObservedObject var weatherVM = WeatherVM()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @EnvironmentObject var store: Store
    var day: Int
    
    var body: some View {
        HStack (alignment: .center) {
            Spacer().frame(width: 70)
            VStack (alignment: .leading, spacing: 0) {
                HStack {
                    Text("\(weatherVM.dailyDays[day])")
                        .fontWeight(.semibold)
                    Text("\(weatherVM.dailyDates[day])")
                        .fontWeight(.light)
                }
                Text("\(weatherVM.getTempByUnit(unit: store.tempUnit)[day]) °\(String(store.tempUnit.displayText.prefix(1)))")
                    .fontWeight(.bold)
                    .font(.title2)
                Text("\(weatherVM.dailyConditions[day].uppercased())")
                    .fontWeight(.light)
                    .font(.footnote)
            }
            Spacer()
            weatherVM.getWeatherIconFor(icon: weatherVM.dailyWeatherIcons[day])
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70, alignment: .trailing)
            
            Spacer().frame(width: 70)
        }
        .padding(10)
        .foregroundColor(Color("TextColor"))
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
//        .background(
//            RoundedRectangle(cornerRadius: 20)
//                .frame(width: 300, height: 100)
//                .foregroundColor(.white.opacity(0.7))
                //.foregroundColor(Color("ThemeColor"))
        //)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct WeatherDay_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDay(day: 0)
            .previewLayout(.sizeThatFits)
            .environmentObject(Store())
    }
}
