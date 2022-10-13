//
//  SettingsView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/7/22.
//

import SwiftUI

struct SettingsView: View {

    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("unit") private var tempUnit: TemperatureUnit = .celsius
    @State private var isUnitChanged: Bool = false
    @EnvironmentObject var store: Store
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    Section(header:
                                HStack {
                        Text("Weather Channel")
                    }) {
                        About()
                            .padding()
                    }
                    
                    Section(header:
                                HStack {
                        Text("Apperance")
                    }) {
                        Picker("Theme", selection: $isDarkMode) {
                            Text("Light Mode")
                                .preferredColorScheme(.light)
                                .tag(false)
                            Text("Dark Mode")
                                .preferredColorScheme(.dark)
                                .tag(true)
                        }
                        .padding(.vertical, 3)
                    }
                    
                    Section(header:
                                HStack {
                        Text("Choose Temperature Units")
                    }) {
                        VStack (alignment: .leading) {
                            Text("Units")

                            Picker(selection: $tempUnit, label: Text("Select temperature unit?")) {
                                ForEach(TemperatureUnit.allCases, id: \.self) {
                                    Text("\($0.displayText)" as String)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                            Spacer()
                        }
                        
                    }
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                Text("")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
            }
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                store.tempUnit = tempUnit
            }) {
                Image(systemName: "xmark")
            }
            )
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

// MARK: - BODY
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.light)
            .environmentObject(Store())
    }
}
