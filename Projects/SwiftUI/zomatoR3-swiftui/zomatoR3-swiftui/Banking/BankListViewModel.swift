//
//  BankListViewModel.swift
//  zomatoR3-swiftui
//
//  Created by Deepak Kumar1 on 13/08/25.
//

import SwiftUI

class BankListViewModel: ObservableObject {
    @Published var bankList: [BankModel]
    @Published var transactionList: [TransactionModel] = []
    @Published var totalAmount = ""
    
    let notificationName = Notification.Name("BankDataUpdated")
    
    init() {
        bankList = BankManagerNew.shared.getBankData(of: nil)
        transactionList = BankManagerNew.shared.getTransactionList(of: nil)
        totalAmount = BankManagerNew.shared.getTotalBalance()
        addObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func undoTransaction() {
        BankManagerNew.shared.undoLatestTransaction(of: nil)
    }
    
    func redoTransaction() {
        BankManagerNew.shared.redoLatestTransaction(of: nil)
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(syncLatestData(notification:)), name: notificationName, object: nil)
    }
    
    @objc
    func syncLatestData(notification: NSNotification) {
        bankList = BankManagerNew.shared.getBankData(of: nil)
        transactionList = BankManagerNew.shared.getTransactionList(of: nil)
        totalAmount = BankManagerNew.shared.getTotalBalance()
    }
}
