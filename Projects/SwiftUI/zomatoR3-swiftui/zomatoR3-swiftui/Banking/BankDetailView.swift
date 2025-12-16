//
//  BankDetailView.swift
//  zomatoR3-swiftui
//
//  Created by Deepak Kumar1 on 13/08/25.
//
import SwiftUI

struct BankDetailView: View {
    @ObservedObject var viewModel: BankDetailViewModel
    
    @State var amount: String = ""
    @State var name: String = ""
    
    
    
    
    var body: some View {
        VStack {
            Text("\(viewModel.bankData.name)")
            Text("Available Amount: \(viewModel.bankData.balanceAmount)")
            
            TextField("Enter Amount to transfer", text: $amount)
            TextField("Enter name ", text: $name)
            Button {
                viewModel.createTransaction(amount: amount, name: name)
            } label: {
                Text("Pay Now")
            }
            
            HStack {
                Button {
                    viewModel.undoTransaction()
                } label: {
                    Text("Undo")
                }
                Spacer()
                Button {
                    viewModel.redoTransaction()
                } label: {
                    Text("Redo")
                }
            }
            .padding(.top, 24)
            .padding(.bottom, 24)
            
            Text("Transaction List")
                .padding(.top, 24)
            
            
            ForEach(viewModel.transactionList, id: \.self) { data in
                TransactionView(data: data)
            }
            

        }
    }
}

//#Preview {
//    BankDetailView(viewModel: BankDetailViewModel(bankData: BankManager.shared.getBankList().first!))
//}
