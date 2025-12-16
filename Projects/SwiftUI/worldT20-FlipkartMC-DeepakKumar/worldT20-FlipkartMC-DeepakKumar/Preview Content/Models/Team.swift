//
//  Team.swift
//  worldT20-FlipkartMC-DeepakKumar
//
//  Created by Deepak Kumar1 on 27/07/25.
//
import Foundation

struct Team: Codable, Identifiable, Equatable, Hashable {
    var name: String
    var flag: String
    let id = UUID()
}
