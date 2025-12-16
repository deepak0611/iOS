//
//  Post.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 08/08/25.
//

import Foundation
import SwiftUI

class Post: Identifiable, ObservableObject {
    let id: UUID
    let author: User
    let caption: String
    @Published var likedBy: [UUID]
    let images: [String]
    let location: String
    let createdAt: Double
    
    init(id: UUID, author: User, caption: String, likedBy: [UUID], images: [String], location: String, createdAt: Double) {
        self.id = id
        self.author = author
        self.caption = caption
        self.likedBy = likedBy
        self.images = images
        self.location = location
        self.createdAt = createdAt
    }
    
    func isLikedByCurrentUser() -> Bool {
        if likedBy.contains(UserManager.shared.getCurrentUser().id) {
            return true
        }
        return false
    }
}
