//
//  AddLocationView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/11/22.
//

import SwiftUI
import CoreData

struct AddLocationView: View {
    
    @State private var locationList: [String] = []
    @State var myWeather: ForecastViewModel!
    @StateObject private var addCityVM = AddCityViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @EnvironmentObject var store: Store
    @State private var activeSheet: Sheets?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
                ZStack {
                    VStack (spacing: 5) {
                        HStack {
                            Text("Location List")
                                .foregroundColor(Color("TextColor"))
                                .fontWeight(.bold)
                                .font(.title)
                        }
                        
                        ZStack {
                            
                         RoundedRectangle(cornerRadius: 15)
                                .background(.ultraThinMaterial.opacity(0.1))
                                .frame(width: 350, height: 45)
       
                            HStack {
                                Spacer()
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 50)
                                    .padding()
                                    .foregroundColor(Color("TextColor"))

                                TextField("Search for a city", text: $addCityVM.city)
                                    .padding(1)
                                    .font(.title2)
                            }
                        }                                                               
                        List {
                            ForEach(store.weatherLocList, id: \.cityName) { myWeather in
                                NavigationLink(destination: DetailScreen(myWeather: myWeather)) {
                                    WeatherCell(myWeather: myWeather)
                                }
                                .listRowBackground(Color.clear)
                                
                            }
                            .onDelete(perform: store.deleteToDo)
                            .listRowBackground(Color.clear)
                        } // End of List
                        .listStyle(.insetGrouped)
                    }
                    .padding(.horizontal)
                }
            .navigationBarItems(leading: Button(action: {}, label: {
                NavigationLink(destination: HomeScreenView())
                {
                    Image(systemName: "chevron.backward.circle.fill").font(.system(size: 20)).padding(10)
                        .offset(x:1,y:1)
                        .font(.title)
                        .foregroundColor(Color("TextColor"))
                }
            })
            )
            .navigationBarItems(trailing: Button( action: {
                addCityVM.getCity { myWeather in
                    store.addWeather(myWeather)
                }
            }) {
                Image(systemName: "plus.circle.fill").font(.system(size: 20)).padding(10)
                    .offset(x:1,y:1)
                    .font(.title)
                    .foregroundColor(Color("TextColor"))
            })
            .background(
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all))
        } //End of Navigation View
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .navigationBarHidden(true)
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView().environmentObject(Store())
    }
}
