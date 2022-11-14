//
//  MainScreen.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 11/14/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    @State private var showingSettingsView: Bool = false
    @State private var activeSheet: Sheets?
    @EnvironmentObject var store: Store
    @AppStorage("isDarkMode") private var isDarkMode = false

    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 20) {
                    if let location = locationManager.location {
                        if let weather = weather {
                            HomeScreenView(weather: weather)
                        } else {
                            LoadingView()
                                .task {
                                    do {
                                        weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                                    } catch {
                                        print("Error getting weather: \(error)")
                                    }
                                }
                        }
                    } else {
                        if locationManager.isLoading {
                            LoadingView()
                        } else {
                            WelcomeView()
                                .environmentObject(locationManager)
                        }
                    }
                }
//                    CurrentLocation()
//                        .offset(x: 0, y: -20)
//
//                    CurrentWeather()
//                        .offset(x: 0, y: -20)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal)
                .background(
                    Image("Background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(.all)
                    
                        .navigationBarItems(leading: Button(action: {
                            self.showingSettingsView.toggle()
                        }) {
                            Image(systemName: "gearshape.fill")
                                .foregroundColor(Color("TextColor"))
                                .padding()
                        })
                )
                .sheet(isPresented: $showingSettingsView) {
                    SettingsView()
                }.preferredColorScheme(isDarkMode ? .dark : .light)
            }.navigationBarHidden(true)
            
        }
    }
//}

//struct MainScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainScreenView_Previews().environmentObject(Store())
//    }
//}
