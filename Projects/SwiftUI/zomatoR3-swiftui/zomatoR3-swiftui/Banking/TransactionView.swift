//
//  TransactionView.swift
//  zomatoR3-swiftui
//
//  Created by Deepak Kumar1 on 13/08/25.
//
import SwiftUI

struct TransactionView: View {
    let data: TransactionModel
    
    var body: some View {
        HStack {
            VStack {
                Text("\(data.beneficiaryName)")
                Text("\(data.bankName)")
            }
            
            Spacer()
            Text("\(data.amount)")
        }
        .background(Color.gray.opacity(0.2))
    }
}


//#Preview {
//    TransactionView(data: TransactionModel(id: UUID(), bankId: UUID(), bankName: "SBI Bank", beneficiaryName: "Deepak", amount: 300))
//}
