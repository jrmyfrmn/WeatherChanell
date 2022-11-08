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

    let myWeather: WeatherViewModel
    let id = UUID()
    
    var body: some View {
        ZStack {            
            RoundedRectangle(cornerRadius: 15)
                   .background(.ultraThinMaterial.opacity(0.1))
                   .frame(width: 300)
            
            HStack (alignment: .center, spacing: 0) {
                Text("\(myWeather.cityName)")
                    .font(.headline)
                    .fixedSize()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding()
                
                myWeather.getWeatherIconForCity(icon: myWeather.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                
                VStack (alignment: .leading) {
                    Text("\(myWeather.getTempByUnit(unit: store.tempUnit))° \(String(store.tempUnit.displayText.prefix(1)))")
//                    Text("\(myWeather.getTempByUnit(unit: store.tempUnit)[0]) °\(String(store.tempUnit.displayText.prefix(1)))")
//                    Text("\(myWeather.dailyConditions[0].uppercased())")
                        
                }
                .font(.footnote)
                .padding()
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color("ThemeColor"))
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            //.background(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke())
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        }
}

struct LocationList_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView().environmentObject(Store())
    }
}
