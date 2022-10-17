//
//  LocationList.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/12/22.
//

import SwiftUI

struct LocationList: View {
      
    @AppStorage("isDarkMode") private var isDarkMode = false
    @EnvironmentObject var store: Store
    @StateObject var weatherVM = WeatherVM()
    
    let id = UUID()
    let locationName: String
    
    var body: some View {
        HStack (alignment: .center, spacing: 0) {
            Text("\(weatherVM.city), \(weatherVM.currentCountry)")
                .font(.headline)
                .fixedSize()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            
            weatherVM.getWeatherIconFor(icon: weatherVM.dailyWeatherIcons[0])
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
            
            VStack (alignment: .leading) {
                Text("\(weatherVM.getTempByUnit(unit: store.tempUnit)[0]) °\(String(store.tempUnit.displayText.prefix(1)))")
                Text("\(weatherVM.dailyConditions[0].uppercased())")
            }
            .font(.footnote)
            .frame(width: 100, alignment: .topTrailing)
            
        }
        .padding(.vertical)
        .foregroundColor(.black.opacity(0.7))
       .background(RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color("ThemeColor"))
           .frame(width: 345, height: 60)
        )
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct LocationList_Previews: PreviewProvider {
    static var previews: some View {
        LocationList(weatherVM: WeatherVM(), locationName: "Makati")
            .previewLayout(.sizeThatFits)
            .environmentObject(Store())
    }
}
