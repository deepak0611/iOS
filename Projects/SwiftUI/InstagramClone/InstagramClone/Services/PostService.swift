//
//  PostService.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 08/08/25.
//
import Foundation

protocol PostService {
    func getAllPosts() -> [Post]
    func getPosts(of userId: UUID) -> [Post]
    func createPost(with data: Post)
    func updatePostLike(postId: UUID, userId: UUID)
}

class PostManager: PostService, ObservableObject {
    
    static var shared = PostManager()
    private init() {}
    
    @Published var postList: [Post] = []

    func getAllPosts() -> [Post] {
        return postList
    }
    
    func getPosts(of id: UUID) -> [Post] {
        let list = postList.filter {
            $0.author.id == id
        }
        return list
    }
    
    func createPost(with data: Post) {
        DispatchQueue.main.async {
            self.postList.append(data)
        }
    }
    
    func updatePostLike(postId: UUID, userId: UUID) {
        NetworkService.shared.getData()
        
        let id = postList.firstIndex {
            $0.id == postId
        }
        guard let id else { return }
        
        let uid = postList[id].likedBy.firstIndex {
            $0 == userId
        }
        guard let uid else {
            DispatchQueue.main.async {
                self.postList[id].likedBy.append(userId)
            }
            return
        }
        DispatchQueue.main.async {
            self.postList[id].likedBy.remove(at: uid)
        }
        
        
    }
    
}


//    [
//        Post(id: UUID(), userId: "Johndoe859", caption: "Poting my first instagram Post here..", likedCount: 26, images: [
//            "https://imgstatic.phonepe.com/images/app-icons-ia-1/wealth-management/insurance/640/640/CH_INS.png",
//            "https://imgstatic.phonepe.com/images/app-icons-ia-1/wealth-management/insurance/640/640/TERM_LIFE_INS.png",
//            "https://imgstatic.phonepe.com/images/app-icons-ia-1/wealth-management/insurance/640/640/CAR_INS.png"
//        ], location: "Iran"),
//        Post(id: UUID(), userId: "deepak0611", caption: "Proud of India..", likedCount: 8, images: [
//            "https://imgstatic.phonepe.com/images/app-icons-ia-1/wealth-management/insurance/640/640/TWO_WHEELER_INS.png"
//        ], location: "India"),
//        Post(id: UUID(), userId: "harish84", caption: "Proud of India..", likedCount: 12, images: [
//            "https://imgstatic.phonepe.com/images/app-icons-ia-1/wealth-management/insurance/assets/160/160/carousel_1_reminders.png",
//            "https://imgstatic.phonepe.com/images/app-icons-ia-1/wealth-management/insurance/assets/160/160/carousel_2_destination.png"
//        ], location: "India")
//    ]
