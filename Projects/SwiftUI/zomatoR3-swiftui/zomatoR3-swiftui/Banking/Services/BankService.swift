//
//  BankService.swift
//  zomatoR3-swiftui
//
//  Created by Deepak Kumar1 on 13/08/25.
//

import Foundation

protocol BankService {
    func deductAmount(value: Int, id: UUID) -> BankModel?
    func addAmount(value: Int, id: UUID) -> BankModel?
    func getBankList() -> [BankModel]
}

class BankManager: BankService {
    func deductAmount(value: Int, id: UUID) -> BankModel? {
        let id = bankList.firstIndex {
            $0.id == id
        }
        guard let id else {
            return nil
        }
        bankList[id].balanceAmount -= value
        return bankList[id]
        
    }
    
    func addAmount(value: Int, id: UUID) -> BankModel? {
        let id = bankList.firstIndex {
            $0.id == id
        }
        guard let id else {
            return nil
        }
        bankList[id].balanceAmount += value
        return bankList[id]
    }
    
    func getBankList() -> [BankModel] {
        return bankList
    }
    
    func getBank(with id: UUID) -> BankModel? {
        let id = bankList.firstIndex {
            $0.id == id
        }
        guard let id else {
            return nil
        }
        return bankList[id]
    }
    
    var bankList: [BankModel] = [
        BankModel(id: UUID(), name: "SBI Bank", balanceAmount: 7865),
        BankModel(id: UUID(), name: "ICICI Bank", balanceAmount: 6733),
        BankModel(id: UUID(), name: "Kotak Bank", balanceAmount: 872643)
    ]
    
    static var shared = BankManager()
    private init() {}
    
}
