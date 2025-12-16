//
//  MatchCenterViewModel.swift
//  worldT20-FlipkartMC-DeepakKumar
//
//  Created by Deepak Kumar1 on 27/07/25.
//

import Foundation

class MatchCenterViewModel: ObservableObject {
//    @Published var playingTeams = [Team]()
    @Published var teamScore: [TeamScore] = [
        TeamScore(score: 0, wicket: 0, balls: 0),
        TeamScore(score: 0, wicket: 0, balls: 0)
    ]
   
    @Published var team1Name: String
    @Published var team2Name: String
    
    init(team1Name: String, team2Name: String) {
        self.team1Name = team1Name
        self.team2Name = team2Name
    }
    
//    init(selectedTeams: [Team]) {
//        self.playingTeams = selectedTeams
//    }

    
}
