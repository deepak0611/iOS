//
//  worldT20_FlipkartMC_DeepakKumarApp.swift
//  worldT20-FlipkartMC-DeepakKumar
//
//  Created by Deepak Kumar1 on 27/07/25.
//

import SwiftUI

class Theme: ObservableObject {
    let theme: String = "Light Theme"
}

@main
struct worldT20_FlipkartMC_DeepakKumarApp: App {
    let theme = Theme()
    var body: some Scene {
        WindowGroup {
//            ContentView()
            SelectTeamView()
                .environmentObject(theme)
        }
    }
}
