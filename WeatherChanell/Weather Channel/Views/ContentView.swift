//
//  ContentView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 9/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    @ObservedObject var cityVM = CityViewViewModel()
    @State var weather: WeatherResponse?
    var networkManager = NetworkManager()
    
    enum Assets {
        static let modes = Image("modes")
    }
    
    var body: some View {
        HStack {
            ZStack(alignment: .bottom) {
                Assets
                    .modes
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if let location = locationManager.location {
                        if weather != nil {
                            TodayWeatherView(cityVM: CityViewViewModel())
                        } else {
                            LoadingView()
                                .task {
                                    do {
                                        weather = try await
                                        networkManager.fetch(latitude: location.latitude, longitude: location.longitude)
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
                } // End of VStack
                
//                VStack(spacing: 0) {
//                    MenuHeaderView(cityVM: cityVM).padding(30)
//                    ScrollView(showsIndicators: false) {
//                        CityView(cityVM: cityVM)
//
//                    }.padding(.top, 2)
//                }.padding(.top, 5)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDisplayName("LightMode")
                .preferredColorScheme(.light)
            ContentView()
                .previewDisplayName("DarkMode")
                .preferredColorScheme(.dark)
        }
    }
}
