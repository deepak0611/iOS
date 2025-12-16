//
//  ChatApp_SwiftUIApp.swift
//  ChatApp-SwiftUI
//
//  Created by Deepak Kumar1 on 26/08/25.
//

import SwiftUI

@main
struct ChatApp_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//        }
//    }
    
    // For quick testing you can use a public echo server which echoes back strings
    // NOTE: Replace this with your own WS endpoint, e.g., wss://yourhost/chat
    private let demoURL = URL(string: "ws://localhost:3001/chat")!

    var body: some Scene {
        WindowGroup {
            ChatView(serverURL: demoURL, me: "alice")
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
