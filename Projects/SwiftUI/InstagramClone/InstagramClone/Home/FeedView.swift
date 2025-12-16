//
//  FeedView.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 05/08/25.
//
import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel: FeedViewModel
    @EnvironmentObject var postManager: PostManager
    
    var data: [String] = ["dsf", "dkjsfb", "sdmb", "ekjfb", "wkdjbf", "djhvf"]
    
    var body: some View {
            
        NavigationStack {
            //        topScrollView
            
            
            
            ScrollView {
                VStack {
                    ForEach(postManager.postList, id: \.id) { post in
                        PostView(post: post)
                    }
                }
            }
            
            
        }
        
        
    }
    
    private var topScrollView: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 12) {
                ForEach(data, id: \.self) { story in
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 64, height: 64)
                        .background(Color.red)
                        .clipShape(Circle())
                }
                
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(Color.blue.opacity(0.2))
    }
    
    
    
}

//#Preview {
//    FeedView(viewModel: FeedViewModel())
//}




