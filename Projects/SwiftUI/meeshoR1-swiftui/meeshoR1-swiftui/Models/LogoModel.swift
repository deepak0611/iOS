//
//  LogoModel.swift
//  meeshoR1-swiftui
//
//  Created by Deepak Kumar1 on 01/09/25.
//
import Foundation

struct LogoModel: Codable {
    let imgUrl: String
    let name: String
}

struct Letters: Identifiable, Hashable {
    static func == (lhs: Letters, rhs: Letters) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: UUID
    let value: String
    let isMasked: Bool
    let index: Int
}
