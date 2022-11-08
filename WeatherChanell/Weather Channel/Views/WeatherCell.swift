//
//  WeatherCell.swift
//  ForecastingWeather
//
//  Created by jeremy.fermin on 11/8/22.
//

import SwiftUI

struct WeatherCell: View {
//MARK: - Property
    let myWeather: WeatherViewModel
    @EnvironmentObject var store: Store
//MARK: - Body
    var body: some View {
        HStack (alignment: .center){
            Spacer().frame(width: 10)
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(myWeather.cityName)
                        .fontWeight(.semibold)
                }
                Text("\(myWeather.getTempByUnit(unit: store.tempUnit))° \(String(store.tempUnit.displayText.prefix(1)))")
                    .fontWeight(.bold)
                    .font(.title2)
                
                Text(myWeather.description.capitalized)
                    .font(.system(size: 15))
            }
            Spacer()
                    myWeather.getWeatherIconForCity(icon: myWeather.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70, height: 70, alignment: .trailing)
                    }//Hstack
                }//Hstack
            }//Vstack
//MARK: - Preview
//struct WeatherCell_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherCell()
//    }
//}
