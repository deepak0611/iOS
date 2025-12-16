//
//  MainTabViewModel.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 15/08/25.
//
import Foundation

class MainTabViewModel: ObservableObject {
    let userManager = UserManager.shared
    
    let notificationName = Notification.Name(rawValue: "UserChanged")
    @Published var loggedInUser: User? = nil
    
    init() {
        createUsers()
        createPosts()
        createObservers()
        setCurrentUser()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createUsers() {
        userManager.createUser(with: User(id: UUID(), name: "Deepak Kumar Singh", userName: "deepak0611", profileImage: "pencil", followerCount: 0, followingCount: 0))
        userManager.createUser(with: User(id: UUID(), name: "Shreya Jain", userName: "shreyaJ", profileImage: "trash.fill", followerCount: 0, followingCount: 0))
        userManager.createUser(with: User(id: UUID(), name: "Kratya Raipuria", userName: "kratyaraipuria_", profileImage: "tray", followerCount: 0, followingCount: 0))
        userManager.createUser(with: User(id: UUID(), name: "Shubham Mittal", userName: "shubham_0709", profileImage: "document.fill", followerCount: 0, followingCount: 0))
        userManager.createUser(with: User(id: UUID(), name: "Vishal Babal", userName: "_babal__", profileImage: "clipboard.fill", followerCount: 0, followingCount: 0))
        userManager.createUser(with: User(id: UUID(), name: "Sritam Behera", userName: "sritam_2310", profileImage: "arrowshape.left.fill", followerCount: 0, followingCount: 0))
    }
    
    func setCurrentUser() {
        let userList = userManager.getAllUsers()
        let id = Int.random(in: 0..<userList.count)
        userManager.setCurrentUser(with: userList[id].id)
    }
    
    func createPosts() {
        let userList = userManager.getAllUsers()
        var id = Int.random(in: 0..<userList.count)
        
        PostManager.shared.createPost(with: Post(id: UUID(), author: userList[id], caption: "first post lots of fun", likedBy: [], images: ["pencil", "plus"], location: "India", createdAt: Date().timeIntervalSince1970))
        
        id = Int.random(in: 0..<userList.count)
        
        PostManager.shared.createPost(with: Post(id: UUID(), author: userList[id], caption: "second post lots of fun", likedBy: [], images: ["clipboard.fill"], location: "Bihar", createdAt: Date().timeIntervalSince1970))
        
        id = Int.random(in: 0..<userList.count)
        
        PostManager.shared.createPost(with: Post(id: UUID(), author: userList[id], caption: "third post lots of fun", likedBy: [], images: ["arrowshape.left.fill"], location: "Bihar", createdAt: Date().timeIntervalSince1970))
        
        id = Int.random(in: 0..<userList.count)
        
        PostManager.shared.createPost(with: Post(id: UUID(), author: userList[id], caption: "third post lots of fun Pizza Party", likedBy: [], images: ["arrowshape.left.fill"], location: "London", createdAt: Date().timeIntervalSince1970))
        
        id = Int.random(in: 0..<userList.count)
        
        PostManager.shared.createPost(with: Post(id: UUID(), author: userList[id], caption: "third post lots of fun Burger Party", likedBy: [], images: ["arrowshape.left.fill"], location: "New York", createdAt: Date().timeIntervalSince1970))
        
        id = Int.random(in: 0..<userList.count)
        
        PostManager.shared.createPost(with: Post(id: UUID(), author: userList[id], caption: "third post lots of fun Momos Party", likedBy: [], images: ["arrowshape.left.fill"], location: "New Delhi", createdAt: Date().timeIntervalSince1970))
        
        id = Int.random(in: 0..<userList.count)
        
        PostManager.shared.createPost(with: Post(id: UUID(), author: userList[id], caption: "third post lots of fun Litti Party", likedBy: [], images: ["arrowshape.left.fill"], location: "Patna", createdAt: Date().timeIntervalSince1970))
        
        id = Int.random(in: 0..<userList.count)
        
        PostManager.shared.createPost(with: Post(id: UUID(), author: userList[id], caption: "third post lots of fun Poha Party", likedBy: [], images: ["arrowshape.left.fill"], location: "Indore", createdAt: Date().timeIntervalSince1970))
        
       
        
    }
    
    
    func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(UserChanged(notification:)), name: notificationName, object: nil)
    }
    
    @objc
    func UserChanged(notification: NSNotification) {
        DispatchQueue.main.async {
            self.loggedInUser = self.userManager.getCurrentUser()
        }
    }
}
