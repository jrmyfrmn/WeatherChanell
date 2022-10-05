//
//  ContentView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 9/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var cityVM = CityViewViewModel()
    
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
                
                VStack(spacing: 0) {
                    MenuHeaderView(cityVM: cityVM).padding(30)
                    ScrollView(showsIndicators: false) {
                        CityView(cityVM: cityVM)
                        
                    }.padding(.top, 2)
                }.padding(.top, 5)
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
