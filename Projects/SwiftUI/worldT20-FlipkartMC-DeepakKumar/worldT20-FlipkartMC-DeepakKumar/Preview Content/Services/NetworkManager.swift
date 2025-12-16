//
//  NetworkManager.swift
//  worldT20-FlipkartMC-DeepakKumar
//
//  Created by Deepak Kumar1 on 27/07/25.
//
import Foundation


class NetworkManager {
    static let shared = NetworkManager()
    var teamData: [Team] = []
    func getTeamData() -> [Team] {
        if(!teamData.isEmpty) {
            return teamData
        }
            
        guard let url = Bundle.main.url(forResource: "TeamJson", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let teams = try? JSONDecoder().decode([Team].self, from: data) else {
                return []
            }
        teamData = teams
            return teams
    }

}
