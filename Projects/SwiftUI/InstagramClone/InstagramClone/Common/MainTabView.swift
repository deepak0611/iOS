//
//  MainTabView.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 08/08/25.
//
import SwiftUI

struct MainTabView: View {
    @StateObject var viewModel = MainTabViewModel()
    
    var body: some View {
        
        TabView {
            
            Tab("Home", systemImage: "house") {
                FeedView(viewModel: FeedViewModel(service: PostManager.shared))
            }
            
            Tab("Profile", systemImage: "person.circle.fill") {
                
                ProfileView(viewModel: ProfileViewModel(user: UserManager.shared.getCurrentUser()))
            }
            
            Tab("Settingd", systemImage: "person.circle.fill") {
                
                SettingsView(viewModel: SettingsViewModel())
            }
            
        }
        .id(viewModel.loggedInUser)
        
        
    }
    
}
