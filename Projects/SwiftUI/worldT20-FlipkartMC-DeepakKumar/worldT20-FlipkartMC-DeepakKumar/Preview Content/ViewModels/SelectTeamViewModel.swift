//
//  SelectTeamViewModel.swift
//  worldT20-FlipkartMC-DeepakKumar
//
//  Created by Deepak Kumar1 on 27/07/25.
//

import Foundation

class SelectTeamViewModel: ObservableObject {
    @Published var teams: [Team] = []
    var PassingTeams: [Team] = []
    
    init() {
        getTeamData()
    }
    
    func getTeamData() {
        self.teams = NetworkManager.shared.getTeamData()
        self.PassingTeams = teams
    }
}
