//
//  About.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 10/12/22.
//

import SwiftUI

struct About: View {

    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(systemName: "iphone")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)

            Spacer()
            Text(" Jeremy's iPhone")
                .font(.subheadline)
                .multilineTextAlignment(.leading)
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
            .previewLayout(.sizeThatFits)
    }
}
