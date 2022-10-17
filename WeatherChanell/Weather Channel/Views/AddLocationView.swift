//
//  AddLocationView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/11/22.
//

import SwiftUI
import CoreData

struct AddLocationView: View {
    
    @State var startCity = Constants.Strings.city
    @EnvironmentObject var dataStore: DataStore
    @ObservedObject var addLocationVM = AddLocationViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Environment(\.presentationMode) var presentationMode
    @State private var locationList: [String] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 5) {
                    HStack {
                        Text("Location List")
                            .foregroundColor(Color("TextColor"))
                            .fontWeight(.bold)
                            .font(.title)
                        
                        Spacer().frame(width: 5)
                    }.padding(.horizontal)
                    ZStack {
                        
                     RoundedRectangle(cornerRadius: 15)
                            .background(.ultraThinMaterial.opacity(0.1))
                            .frame(width: 350, height: 55)
   
                        HStack {
                            Spacer()
                            Image(systemName: "location.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 50)
                                .padding()
                                .foregroundColor(.white)
                            
                            Spacer()
                            TextField("Search", text: $startCity)
                                .padding(.leading, 10)
                                .font(.title2)
                                                        
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical)
                    
                    List {
                        ForEach(locationList, id: \.self) { location in
                            NavigationLink {
                                HomeScreenView()
                            }
                        label: { LocationList(locationName: location)
                        }.listRowBackground(Color.clear)
                        }
                    }.listStyle(.insetGrouped)
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
                Constants.Strings.city = startCity
                locationList.append(startCity)
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
                    .ignoresSafeArea(.all)
            )
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .navigationBarHidden(true)
    }
}

extension AddLocationView {
    func updateToDo() {
        let loc = AddLocation(id: addLocationVM.id!, location: addLocationVM.location)
        dataStore.updateLocation(loc)
        presentationMode.wrappedValue.dismiss()
    }
    
    func addToDo() {
        let loc = AddLocation(location: addLocationVM.location)
        dataStore.addLocation(loc)
        presentationMode.wrappedValue.dismiss()
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var updateSaveButton: some View {
        Button( addLocationVM.updating ? "Update" : "Save",
                action: addLocationVM.updating ? updateToDo : addToDo)
        .disabled(addLocationVM.isDisabled)
    }
}

struct AddLocationView_Previews: PreviewProvider {
    static var previews: some View {
        AddLocationView().environmentObject(Store())
    }
}


