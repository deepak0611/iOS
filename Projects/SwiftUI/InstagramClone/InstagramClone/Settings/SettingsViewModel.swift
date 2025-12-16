//
//  SettingsViewModel.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 15/08/25.
//

import SwiftUI
import Combine

class SettingsViewModel: ObservableObject {
    
    @Published var user: User
    @Published var allUsers: [User] = []
    
    private var cancellables = Set<AnyCancellable>()
    init() {
        self.user = UserManager.shared.getCurrentUser()
        self.allUsers = UserManager.shared.getAllUsers()
        
        $user
            .sink { [weak self] newUser in
                UserManager.shared.setCurrentUser(with: newUser.id)
        }
            .store(in: &cancellables)
        
        
    }
}
