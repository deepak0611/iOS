//
//  InstagramCloneApp.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 05/08/25.
//

import SwiftUI
//import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()

    return true
  }
}

@main
struct InstagramCloneApp: App {
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    let persistenceController = PersistenceController.shared
    
    @StateObject var postManager = PostManager.shared
    
//
//    init() {
//        FirebaseApp.configure()
//    }
    
    var body: some Scene {
        
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
//            SplashScreen()
//            MainTabView()
//                .environmentObject(postManager)

            DrawingView(circlesData: [[855,82,158],[17,719,430],[90,756,164],[376,17,340],[691,636,152],[565,776,5],[464,154,271],[53,361,162],[278,609,82],[202,927,219],[542,865,377],[330,402,270],[720,199,10],[986,697,443],[471,296,69],[393,81,404],[127,405,177]])
//            DummyView()
        }
    }
}
