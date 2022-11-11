////
////  TopNavBar.swift
////  Weather Channel
////
////  Created by jeremy.fermin on 10/12/22.
////
//
//import SwiftUI
//
//struct TopNavBar: View {
//
//    @AppStorage("isDarkMode") private var isDarkMode = false
//
//    let title: String
//
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 20)
//                .foregroundColor(.white.opacity(0.5))
//                .frame(width: 60, height: 30)
//
//            Text(title)
//                .foregroundColor(Color("TextColor"))
//        }
//        .preferredColorScheme(isDarkMode ? .dark : .light)
//    }
//}
//struct TopNavBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TopNavBar(title: "Add")
//            .previewLayout(.sizeThatFits)
//    }
//}
