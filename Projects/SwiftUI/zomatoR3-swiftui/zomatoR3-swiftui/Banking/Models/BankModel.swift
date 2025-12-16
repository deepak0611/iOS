//
//  BankModel.swift
//  zomatoR3-swiftui
//
//  Created by Deepak Kumar1 on 13/08/25.
//
import Foundation

class BankModel: Hashable {
    static func == (lhs: BankModel, rhs: BankModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
        
    
    var id: UUID
    var name: String
    var balanceAmount: Int
    
    init(id: UUID, name: String, balanceAmount: Int) {
        self.id = id
        self.name = name
        self.balanceAmount = balanceAmount
    }
}
