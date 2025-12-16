//
//  BankDetailViewModel.swift
//  zomatoR3-swiftui
//
//  Created by Deepak Kumar1 on 13/08/25.
//
import SwiftUI

class BankDetailViewModel: ObservableObject {
    
    @Published var bankData: BankModel
    @Published var transactionList: [TransactionModel] = []
    
    let notificationName = Notification.Name("BankDataUpdated")
    
    init(bankId: UUID) {
        self.bankData = BankManagerNew.shared.getBankData(of: bankId).first!
        self.transactionList = BankManagerNew.shared.getTransactionList(of: bankId)
        addObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func createTransaction(amount: String, name: String) {
        
        if let amountValue = Int(amount) {
            let newTransaction = TransactionModel(id: UUID(), bankId: bankData.id, bankName: bankData.name, beneficiaryName: name, amount: amountValue, timeStamp: Date().timeIntervalSince1970)
            BankManagerNew.shared.createTransaction(with: newTransaction)
        }
        
    }
    
    func undoTransaction() {
        BankManagerNew.shared.undoLatestTransaction(of: bankData.id)
    }
    
    func redoTransaction() {
        BankManagerNew.shared.redoLatestTransaction(of: bankData.id)
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(syncLatestData(notification:)), name: notificationName, object: nil)
    }
    
    @objc
    func syncLatestData(notification: NSNotification) {
        bankData = BankManagerNew.shared.getBankData(of: bankData.id).first!
        transactionList = BankManagerNew.shared.getTransactionList(of: bankData.id)
    }
}
