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
        ZStack {            
            RoundedRectangle(cornerRadius: 15)
                   .background(.ultraThinMaterial.opacity(0.1))
                   .frame(width: 300)
            
            HStack (alignment: .center, spacing: 0) {
                Text("\(weatherVM.city), \(weatherVM.currentCountry)")
                    .font(.headline)
                    .fixedSize()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding()
                
                weatherVM.getWeatherIconFor(icon: weatherVM.dailyWeatherIcons[0])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    //.padding()
                
                VStack (alignment: .leading) {
                    Text("\(weatherVM.getTempByUnit(unit: store.tempUnit)[0]) °\(String(store.tempUnit.displayText.prefix(1)))")
                    Text("\(weatherVM.dailyConditions[0].uppercased())")
                        
                }
                .font(.footnote)
                .padding()
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color("ThemeColor"))
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        }
}

struct LocationList_Previews: PreviewProvider {
    static var previews: some View {
        LocationList(weatherVM: WeatherVM(), locationName: "Makati")
            .previewLayout(.sizeThatFits)
            .environmentObject(Store())
    }
}
