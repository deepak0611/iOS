//
//  User.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 15/08/25.
//
import Foundation

class User: Identifiable, Hashable, Equatable {
    let id: UUID
    let name: String
    let userName: String
    let profileImage: String
    let followerCount: Int
    let followingCount: Int
    
    init(id: UUID, name: String, userName: String, profileImage: String, followerCount: Int, followingCount: Int) {
        self.id = id
        self.name = name
        self.userName = userName
        self.profileImage = profileImage
        self.followerCount = followerCount
        self.followingCount = followingCount
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
