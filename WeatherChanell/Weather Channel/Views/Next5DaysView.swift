//
//  Next5DaysView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/20/22.
//

import SwiftUI

struct Next5DaysView: View {
    
    @State private var showingSettingsView: Bool = false
    @State private var activeSheet: Sheets?
    @EnvironmentObject var store: Store
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 20) {

                    Spacer()
                    
                        .foregroundColor(Color.white)
                    Text("🗓 5-DAY FORECAST")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("TextColor"))
                    
                    Spacer()
                    Spacer()
                    
                    ScrollView (.vertical) {
                        ForEach((1...5), id:\.self) {day in
                            WeatherDay(day: day)
                        }
                    }.offset(x: 0, y: -20)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
                .background(
                    Image("Background")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(.all)
                        .navigationBarItems(leading: Button(action: {}, label: {
                            NavigationLink(destination: HomeScreenView())
                            {
                                Image(systemName: "chevron.backward.circle.fill").font(.system(size: 20)).padding(10)
                                    .offset(x:1,y:1)
                                    .font(.title)
                                    .foregroundColor(Color("TextColor"))
                                    .padding(.bottom)
                            }
                        })
                        )
                )
//                .sheet(isPresented: $showingSettingsView) {
//                    SettingsView()
//                }
            }
            .overlay(
                NavigationLink(destination: AddLocationView()) {
                    ZStack{
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .background(Circle().fill(.clear))
                                .frame(width: 25, height: 25, alignment: .center)
                                .foregroundColor(Color("TextColor"))
                                .padding()
                        }
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

struct Next5DaysView_Previews: PreviewProvider {
    static var previews: some View {
        Next5DaysView().environmentObject(Store())
    }
}
