//
//  HomeScreenView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/11/22.
//

import SwiftUI

struct HomeScreenView: View {
    
    @State private var showingSettingsView: Bool = false
    @State private var activeSheet: Sheets?
    @EnvironmentObject var store: Store
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 20) {
                    CurrentLocation()
                        .offset(x: 0, y: -20)
                    
                    CurrentWeather()
                        .offset(x: 0, y: -20)
                    
                    ScrollView (.vertical) {
                        ForEach((1...5), id:\.self) {day in
                            WeatherDay(day: day)
                        }
                    }.offset(x: 0, y: -20)
                }
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
                                .foregroundColor(.white.opacity(0.7))
                                //.foregroundColor(Color("TextColor"))
                                .padding()
                        })
                )
                .sheet(isPresented: $showingSettingsView) {
                    SettingsView()
                }
            }
            .overlay(
                NavigationLink(destination: AddLocationView()) {
                    ZStack{
                        //ConcCircle()
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(.clear))
                            .frame(width: 30, height: 30, alignment: .center)
                            .foregroundColor(.white.opacity(0.7))
                            //.accentColor(Color("ConcCircleColor"))
                    }
                    .padding(.bottom, 10)
                    .padding(.trailing, 20)
                }
                , alignment: .bottomTrailing
            )
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }.navigationBarHidden(true)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView().environmentObject(Store())
    }
}
