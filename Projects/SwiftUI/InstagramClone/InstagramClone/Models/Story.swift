//
//  Story.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 15/08/25.
//
import Foundation

class Story {
    let id: UUID
    let author: User
    let images: [String]
    let createdAt: Double
    
    init(id: UUID, author: User, images: [String], createdAt: Double) {
        self.id = id
        self.author = author
        self.images = images
        self.createdAt = createdAt
    }
}
