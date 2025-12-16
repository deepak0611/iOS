//
//  ProfileView.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 15/08/25.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    @EnvironmentObject var postManager: PostManager
    
    
    var body: some View {
        
        detailView
        ScrollView {
            VStack {
                ForEach(postManager.getPosts(of: viewModel.user.id), id: \.id) { post in
                    PostView(post: post)
                }
            }
        }
        
    }
    
    private var detailView: some View {
        
        HStack(alignment: .bottom, spacing: 12) {
            VStack {
                Image(systemName: "\(viewModel.user.profileImage)")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding(12)
                    .background(Color.gray)
                Text("\(viewModel.user.name)")
            }
            Spacer()
            VStack {
                Text("\(viewModel.user.followerCount)")
                Text("Followers")
            }
            Spacer()
            VStack {
                Text("\(viewModel.user.followingCount)")
                Text("Following")
            }
            
            
            
        }
        .padding(.horizontal,24)
        
    }
    
//    private var userSelectionView: some View {
//        HStack {
//            Text("Current UserName: \(viewModel.user.userName)")
//            Picker("Picker User", selection: $viewModel.user) {
//                ForEach(viewModel.allUsers, id: \.id) { user in
//                    Text("\(user.name)")
//                        .tag(user)
//                }
//            }.pickerStyle(.menu)
//        }
//    }
    
}



