//
//  MenuHeaderView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 9/15/22.
//

import SwiftUI

struct MenuHeaderView: View {
    
    @ObservedObject var cityVM: CityViewViewModel
    
    @State private var searchTerm = "Makati"
    
    var body: some View {
        HStack {
            TextField("", text: $searchTerm)
                .padding(.leading, 20)
            
            Button {
                cityVM.city = searchTerm
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.blue)
                    
                    Image(systemName: "location.fill")
                }
            }
            .frame(width: 50, height: 50)
        }
        .foregroundColor(.white)
        .padding()
        .background(ZStack(alignment: .leading) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
                .padding(.leading, 10)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
        })
    }
}

struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
