//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 08/08/25.
//
import SwiftUI

class FeedViewModel: ObservableObject {
    private let feedService: PostService
    @Published var feedData: [Post]
    init(service: PostService) {
        self.feedService = service
        feedData = feedService.getAllPosts()
    }
}
