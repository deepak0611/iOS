//
//  meeshoR1_swiftuiApp.swift
//  meeshoR1-swiftui
//
//  Created by Deepak Kumar1 on 01/09/25.
//

import SwiftUI

@main
struct meeshoR1_swiftuiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            GameView()
        }
    }
}
