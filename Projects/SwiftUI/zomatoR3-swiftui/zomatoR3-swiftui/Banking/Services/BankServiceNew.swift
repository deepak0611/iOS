//
//  BankServiceNew.swift
//  zomatoR3-swiftui
//
//  Created by Deepak Kumar1 on 14/08/25.
//

import SwiftUI

protocol BankServiceNew {
    func createTransaction(with data: TransactionModel)
    func undoLatestTransaction(of bankId: UUID?)
    func redoLatestTransaction(of bankId: UUID?)
    func getTransactionList(of bankId: UUID?) -> [TransactionModel]
    func getBankData(of bankId: UUID?) -> [BankModel]
    func getTotalBalance() -> String
}

class BankManagerNew: BankServiceNew {
    
    static var shared = BankManagerNew()
    private init() {}
    
    private var bankList: [BankModel] = [
        BankModel(id: UUID(), name: "SBI Bank", balanceAmount: 8000),
        BankModel(id: UUID(), name: "ICICI Bank", balanceAmount: 6000),
        BankModel(id: UUID(), name: "Kotak Bank", balanceAmount: 2000)
    ]
    
    private var transactionList: [TransactionModel] = []
    private var undoTransactionList: [TransactionModel] = []
    let notificationName = Notification.Name("BankDataUpdated")
    
    func createTransaction(with data: TransactionModel) {
        transactionList.append(data)
        deductAmount(with: data)
        postNotification()
    }
    
    func undoLatestTransaction(of bankId: UUID?)  {
        if(!transactionList.isEmpty) {
            if bankId != nil {
                let id = transactionList.lastIndex {
                    $0.bankId == bankId
                }
                guard let id else { return }
                let removedTransaction = transactionList.remove(at: id)
                undoTransactionList.append(removedTransaction)
                addAmount(with: removedTransaction)
            } else {
                let lastElement = transactionList.removeLast()
                undoTransactionList.append(lastElement)
                addAmount(with: lastElement)
            }
        }
        postNotification()
    }
    
    func redoLatestTransaction(of bankId: UUID?)  {
        if(!undoTransactionList.isEmpty) {
            if bankId != nil {
                let id = undoTransactionList.lastIndex {
                    $0.bankId == bankId
                }
                guard let id else { return }
                let removedTransaction = undoTransactionList.remove(at: id)
                transactionList.append(removedTransaction)
                deductAmount(with: removedTransaction)
            } else {
                let lastElement = undoTransactionList.removeLast()
                transactionList.append(lastElement)
                deductAmount(with: lastElement)
            }
        }
        postNotification()
    }
    
    func getTransactionList(of bankId: UUID?) -> [TransactionModel] {
        if(bankId != nil) {
            let list = transactionList.filter {
                $0.bankId == bankId
            }
            return list
        } else {
            return transactionList
        }
    }
    
    func getBankData(of bankId: UUID?) -> [BankModel] {
        if (bankId != nil) {
            let list = bankList.filter {
                $0.id == bankId
            }
            return list
        } else {
            return bankList
        }
    }
    
    func getTotalBalance() -> String {
        var balance: Int = 0
        bankList.forEach { data in
            balance += data.balanceAmount
        }
        return String(balance)
    }
    
    func deductAmount(with data: TransactionModel) {
        let id = bankList.firstIndex {
            $0.id == data.bankId
        }
        
        guard let id else {
            return
        }
        
        bankList[id].balanceAmount -= data.amount
    }
    
    func addAmount(with data: TransactionModel) {
        let id = bankList.firstIndex {
            $0.id == data.bankId
        }
        guard let id else {
            return
        }
        bankList[id].balanceAmount += data.amount
    }
    
    func postNotification() {
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
}
