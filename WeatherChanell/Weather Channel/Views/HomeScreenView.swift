//
//  HomeScreenView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/11/22.
//

import SwiftUI
import CoreLocation

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
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }.navigationBarHidden(true)
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView().environmentObject(Store())
    }
}
