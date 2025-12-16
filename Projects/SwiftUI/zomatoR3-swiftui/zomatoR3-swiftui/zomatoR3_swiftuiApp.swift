//
//  zomatoR3_swiftuiApp.swift
//  zomatoR3-swiftui
//
//  Created by Deepak Kumar1 on 13/08/25.
//

import SwiftUI

@main
struct zomatoR3_swiftuiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            BankDetailView(viewModel: BankDetailViewModel(bankData: BankModel(id: UUID(), name: "SBI Bank", balanceAmount: 8765)))
            BankListView(viewModel: BankListViewModel())
        }
    }
}
