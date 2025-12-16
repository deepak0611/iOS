//
//  TransactionService.swift
//  zomatoR3-swiftui
//
//  Created by Deepak Kumar1 on 13/08/25.
//

import Foundation

protocol TransactionService {
    func createTransaction(with data: TransactionModel) -> [TransactionModel]
    func undoLatestTransaction() -> [TransactionModel]
    func redoLatestTransaction() -> [TransactionModel]
    func getTransactionList(with id: UUID) -> [TransactionModel]?
}

class TransactionManager: TransactionService {
    
    static let shared = TransactionManager()
    
    private init() {}
    
    var transactionList: [TransactionModel] = []
    var undoTransactionList: [TransactionModel] = []
    
    func undoLatestTransaction() -> [TransactionModel] {
        if(!transactionList.isEmpty) {
            let lastElement = transactionList.removeLast()
            undoTransactionList.append(lastElement)
            deductAmountFromBank(data: lastElement)
        }
        
        return transactionList
    }
    
    func redoLatestTransaction() -> [TransactionModel] {
        if(!undoTransactionList.isEmpty) {
            let firstElement = undoTransactionList.removeLast()
            transactionList.append(firstElement)
            addAmountToBank(data: firstElement)
        }
        return transactionList
    }
    
    func createTransaction(with data: TransactionModel) -> [TransactionModel] {
        transactionList.append(data)
        deductAmountFromBank(data: data)
        
        
        return transactionList
    }
    
    func addAmountToBank(data: TransactionModel) {
        BankManager.shared.addAmount(value: data.amount, id: data.bankId)
    }
    
    func deductAmountFromBank(data: TransactionModel) {
        BankManager.shared.deductAmount(value: data.amount, id: data.bankId)
    }
    
    
    func getTransactionList(with id: UUID) -> [TransactionModel]? {
        let list = transactionList.filter {
            $0.bankId == id
        }
        return list
        
    }
    
}
