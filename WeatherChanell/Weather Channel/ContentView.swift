//
//  ContentView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 9/12/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cityVM: CityViewViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                MenuHeaderView(cityVM: cityVM)
                ScrollView(showsIndicators: false) {
                    CityView(cityVM.cityVM)
                }
            }.padding(.top, 30)
        }.background(RoundedRectangle(cornerRadius: 5).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)))
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
