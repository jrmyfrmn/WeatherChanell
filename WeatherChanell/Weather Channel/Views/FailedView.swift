//
//  FailedView.swift
//  ForecastingWeather
//
//  Created by jeremy.fermin on 11/8/22.
//

import SwiftUI

struct FailedView: View {
//MARK: - Body
    var body: some View {
        Image(systemName: "questionmark.square.fill")
    }
}
//MARK: - Preview
struct FailedView_Previews: PreviewProvider {
    static var previews: some View {
        FailedView()
    }
}
