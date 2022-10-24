//
//  WelcomeView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/20/22.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    VStack(spacing: 20) {
                        
                        Text("Welcome to Weather Channel!")
                            .bold()
                            .font(.title)
                        
                        Text("Tap the share current location button to know the weather in your area")
                            .padding()
                    }
                    .multilineTextAlignment(.center)
                    .padding()
                    
                    NavigationLink(destination: HomeScreenView()) {
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 50)
                                .background(.ultraThinMaterial.opacity(0.1))
                                .frame(width: 255, height: 50)
                                .foregroundColor(Color("ThemeColor").opacity(0.6))
                            
                            HStack {
                                
                                Image(systemName: "location.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .background(Circle().fill(.clear))
                                    .frame(width: 15, height: 15, alignment: .center)
                                    .foregroundColor(Color("TextColor"))
                                
                                Text("Share Current Location")
                                    .foregroundColor(Color("TextColor"))
                            }
                        }
                        .padding(.bottom, 10)
                    }
                }
                .padding(.bottom, 10)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                .frame(maxWidth: .infinity, maxHeight: .infinity) // bg size
                .padding(.horizontal)
                .background(
                    Image("Background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(.all)
                )
            } // End of Navigation View
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .navigationBarHidden(true)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
