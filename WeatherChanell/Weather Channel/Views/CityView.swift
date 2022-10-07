//
//  CityView.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 9/22/22.
//

import SwiftUI

struct CityView: View {

    @ObservedObject var cityVM: CityViewViewModel

    var body: some View {
        VStack {
            CityNameView(city: cityVM.city, date: cityVM.date)
                .shadow(radius: 10)
            TodayWeatherView(cityVM: cityVM)
                .padding()
            HourlyWeatherView(cityVM: cityVM)
            DailyWeatherView(cityVM: cityVM)
        }.padding(.bottom, 30)
    }
}

struct CityView_Previews: PreviewProvider {
    static var previews: some View {
        CityView(cityVM: CityViewViewModel())
    }
}
