////
////  ConcCircle.swift
////  Weather Channel
////
////  Created by jeremy.fermin on 10/12/22.
////
//
//import SwiftUI
//
//struct ConcCircle: View {
//
//    @AppStorage("isDarkMode") private var isDarkMode = false
//
//    var body: some View {
//        Group {
//            Circle()
//                .opacity(0.2)
//                .scaleEffect(1)
//                .frame(width: 68, height: 68, alignment: .center)
//            Circle()
//                .opacity(0.15)
//                .scaleEffect(1)
//                .frame(width: 88, height: 88, alignment: .center)
//        }
//        .foregroundColor(Color("ConcCircleColor"))
//        .preferredColorScheme(isDarkMode ? .dark : .light)
//    }
//}
//
//struct AddButton_Previews: PreviewProvider {
//    static var previews: some View {
//        ConcCircle()
//            .previewLayout(.sizeThatFits)
//    }
//}
