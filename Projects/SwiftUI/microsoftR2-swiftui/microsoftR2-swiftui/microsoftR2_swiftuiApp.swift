//
//  microsoftR2_swiftuiApp.swift
//  microsoftR2-swiftui
//
//  Created by Deepak Kumar1 on 04/09/25.
//

import SwiftUI

@main
struct microsoftR2_swiftuiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
