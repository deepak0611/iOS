//
//  ProfileViewModel.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 15/08/25.
//

import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var user: User
//    @Published var allUsers: [User] = []
    
//    private var cancellables = Set<AnyCancellable>()
    init(user: User) {
        self.user = user
//        self.allUsers = UserManager.shared.getAllUsers()
        
//        $user
//            .sink { [weak self] newUser in
//                UserManager.shared.setCurrentUser(with: newUser.id)
//        }
//            .store(in: &cancellables)
    }
}
