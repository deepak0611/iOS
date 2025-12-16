//
//  TransactionModel.swift
//  zomatoR3-swiftui
//
//  Created by Deepak Kumar1 on 13/08/25.
//
import Foundation

struct TransactionModel: Hashable {
    let id: UUID
    let bankId: UUID
    let bankName: String
    let beneficiaryName: String
    let amount: Int
    let timeStamp: Double
}
