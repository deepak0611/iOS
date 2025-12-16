//
//  StoryService.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 15/08/25.
//
import Foundation

protocol StoryService {
    func createStory(with data: Story)
    func getAllValidStories() -> [Story]
}

class StoryManager: StoryService {
    
    static var shared = StoryManager()
    private init() {}
    
    private var storyList: [Story] = []
    
    func createStory(with data: Story) {
        storyList.append(data)
    }
    
    func getAllValidStories() -> [Story] {
        let list = storyList.filter {
            let diff = Date().timeIntervalSince1970 - $0.createdAt
            return diff <= 86400
        }
        return list
    }
    
    
}
