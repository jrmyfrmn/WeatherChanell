//
//  ForecastList.swift
//  ForecastingWeather
//
//  Created by jeremy.fermin on 11/8/22.
//

import SwiftUI

struct ForecastList: View {

    let myWeather: WeatherViewModel
    @EnvironmentObject var store: Store
    @ObservedObject var weatherVM = WeatherVM()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            VStack {
                    ZStack {
                        VStack (spacing: 20) {
                            Text(myWeather.cityName)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .offset(x: 0, y: -20)
                            
                            Text("\(weatherVM.currentDate)")
                                .offset(x: 0, y: -20)
                        
                            HStack {
                                myWeather.getWeatherIconForCity(icon: myWeather.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()

                                Text("\(myWeather.getTempByUnit(unit: store.tempUnit))° \(String(store.tempUnit.displayText.prefix(1)))")
                                    .font(.system(size: 35))
                                    .fontWeight(.semibold)                                
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top)
                        .background(RoundedRectangle(cornerRadius: 30, style: .continuous).stroke())
                        .foregroundColor(Color("TextColor"))
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .preferredColorScheme(isDarkMode ? .dark : .light)
                        
                    }.padding()
                
                Spacer()
                Text("5-DAY FORECAST")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("TextColor"))
                
                Spacer()
                Spacer()
                
                ScrollView (.vertical) {
                    DailyRow(logo: "\(myWeather.getWeatherIconForCity(icon: myWeather.icon))", day: "\(weatherVM.dailyDays[0])", temp: "\(myWeather.getTempByUnit(unit: store.tempUnit))°\(String(store.tempUnit.displayText.prefix(1)))")
                    Divider()
                    DailyRow(logo: "\(myWeather.getWeatherIconForCity(icon: myWeather.icon))", day: "\(weatherVM.dailyDays[1])", temp: "\(myWeather.getTempByUnit(unit: store.tempUnit))°\(String(store.tempUnit.displayText.prefix(1)))")
                    Divider()
                    DailyRow(logo: "\(myWeather.getWeatherIconForCity(icon: myWeather.icon))", day: "\(weatherVM.dailyDays[2])", temp: "\(myWeather.getTempByUnit(unit: store.tempUnit))°\(String(store.tempUnit.displayText.prefix(1)))")
                    Divider()
                    DailyRow(logo: "\(myWeather.getWeatherIconForCity(icon: myWeather.icon))", day: "\(weatherVM.dailyDays[3])", temp: "\(myWeather.getTempByUnit(unit: store.tempUnit))°\(String(store.tempUnit.displayText.prefix(1)))")
                    Divider()
                    DailyRow(logo: "\(myWeather.getWeatherIconForCity(icon: myWeather.icon))", day: "\(weatherVM.dailyDays[4])", temp: "\(myWeather.getTempByUnit(unit: store.tempUnit))°\(String(store.tempUnit.displayText.prefix(1)))")
                }
                .offset(x: 0, y: -5)
                
                }
                .padding()                
                .padding(.horizontal)
                .padding(.bottom, 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity) // bg size
                .background(
                    Image("Background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(.all)
                )
                .navigationBarItems(leading: Button(action: {}, label: {
                    NavigationLink(destination: AddLocationView())
                    {
                        Image(systemName: "chevron.backward.circle.fill").font(.system(size: 20)).padding(10)
                            .offset(x:1,y:1)
                            .font(.title)
                            .foregroundColor(Color("TextColor"))
                    }
                })
                )
        }//NavView
}
    }

struct ForecastList_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView().environmentObject(Store())
    }
}

