//
//  SettingsView.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 15/08/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    
    var body: some View {
        
        userSelectionView
        
    }
    
   
    private var userSelectionView: some View {
        HStack {
            Text("Current UserName: \(viewModel.user.userName)")
            Picker("Picker User", selection: $viewModel.user) {
                ForEach(viewModel.allUsers, id: \.id) { user in
                    Text("\(user.name)")
                        .tag(user)
                }
            }.pickerStyle(.menu)
        }
    }
    
}



