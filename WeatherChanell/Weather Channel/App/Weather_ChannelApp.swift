//
//  Weather_ChannelApp.swift
//  Weather Channel
//
//  Created by jeremy.fermin on 9/12/22.
//

import SwiftUI

@main
struct Weather_ChannelApp: App {
    //let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //ContentView()
            SplashScreenView()
                .environmentObject(Store())
                //.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
