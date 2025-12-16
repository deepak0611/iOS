//
//  UserService.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 15/08/25.
//
import Foundation

protocol UserService {
    func getCurrentUser() -> User
    func createUser(with data: User)
    func setCurrentUser(with id: UUID)
}

class UserManager: UserService {
    
    static var shared = UserManager()
    private init() {}
    
    let notificationName = Notification.Name(rawValue: "UserChanged")
    
    private var userList: [User] = []
    private var currenUser: User = User(id: UUID(), name: "Dummy Name", userName: "dummyUser", profileImage: "", followerCount: 0, followingCount: 0)
    
    
    func getCurrentUser() -> User {
        return currenUser
    }
    
    func getAllUsers() -> [User] {
        return userList
    }
    
    func createUser(with data: User) {
        userList.append(data)
    }
    
    func setCurrentUser(with id: UUID) {
        let id = userList.firstIndex {
            $0.id == id
        }
        guard let id else {
            return
        }
        currenUser = userList[id]
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
    
    
}
