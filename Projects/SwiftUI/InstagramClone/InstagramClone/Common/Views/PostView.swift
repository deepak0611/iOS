//
//  PostView.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 15/08/25.
//
import SwiftUI

struct PostView: View {
    @ObservedObject var post: Post
    @State var showProfile: Bool  = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .frame(width: 42, height: 42)
                    .aspectRatio(contentMode: .fill)
                    .background(Color.red)
                    .onTapGesture {
                        showProfile = true
                        
                        
                    }
                
                    .navigationDestination(isPresented: $showProfile) {
                        ProfileView(viewModel: ProfileViewModel(user: post.author))
                    }
                
                VStack(alignment: .leading) {
                    Text("\(post.author.userName)")
                    Text("\(post.location)")
                }
                Spacer()
            }.padding(12)
            
            if(post.images.count>1) {
                TabView {
                    ForEach(post.images, id: \.self) { imageStr in
                        Image(systemName: "\(imageStr)")
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .frame(height: 300)
                            .background(Color.gray)
                        
//                        AsyncImage(url: URL(string: imageStr), scale: 1) { image in
//                            image
//                                .resizable()
//                                .scaledToFit()
//                                .frame(maxWidth: .infinity)
//                                .frame(height: 300)
//                        } placeholder: {
//                            ProgressView("Loading image...")
//                        }
//                        .background(Color.gray.opacity(0.2))
                    }
                }
                .tabViewStyle(.page)
                .frame(height: 320)
            } else {
                Image(systemName: "\(post.images[0])")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .background(Color.gray)
                
//                AsyncImage(url: URL(string: post.images[0]), scale: 1) { image in
//                    image
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 300)
//                } placeholder: {
//                    ProgressView("Loading image...")
//                }
//                .background(Color.gray.opacity(0.2))
            }
            
            
            
            HStack(spacing: 12) {
                Image(systemName: post.isLikedByCurrentUser() ? "heart.fill" : "heart")
                    .renderingMode(.template)
                    .foregroundStyle(post.isLikedByCurrentUser() ? Color.red : Color.gray)
                    .onTapGesture {
                        PostManager.shared.updatePostLike(postId: post.id, userId: UserManager.shared.getCurrentUser().id)
                    }
                Text("\(post.likedBy.count)")
                Spacer()
            }.padding(8)
            
            Text("\(post.caption)")
        }.background(Color.gray.opacity(0.1))
    }
    
}
