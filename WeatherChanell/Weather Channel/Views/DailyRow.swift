//
//  DailyRow.swift
//  WeatherChannel
//
//  Created by jeremy.fermin 11/11/2022.
//

import SwiftUI

struct DailyRow: View {
//MARK: - Property
    var logo: String
    var day: String
    var temp: String

    var body: some View {
        HStack {
            Text(day)
                .fontWeight(.bold)
                .font(.title2)
            Spacer()
                .frame(width: 80)
            Image(logo)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70, alignment: .trailing)
            Spacer()
                .frame(width: 80)
            Text(temp)
                .fontWeight(.bold)
                .font(.title2)
        }
    }
}

struct DailyRow_Previews: PreviewProvider {
    static var previews: some View {
        DailyRow(logo: "sun", day: "today", temp: "30°C")
    }
}
