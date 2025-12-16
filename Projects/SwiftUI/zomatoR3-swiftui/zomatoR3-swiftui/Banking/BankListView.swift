//
//  BankListView.swift
//  zomatoR3-swiftui
//
//  Created by Deepak Kumar1 on 13/08/25.
//

import SwiftUI

struct BankListView: View {
    
    @ObservedObject var viewModel: BankListViewModel
    @State var path = NavigationPath()
    var body: some View {
        
        NavigationStack(path: $path) {
            VStack {
                
                List(viewModel.bankList, id: \.id) { bank in
                    HStack {
                        Text("\(bank.name)")
                        Spacer()
                        Text("\(bank.balanceAmount)")
                        
                    }
                    .onTapGesture {
                        path.append(bank)
                    }
                }
                
                Text("\(viewModel.totalAmount)")
                
                
                
                
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
            .navigationDestination(for: BankModel.self) { data in
                BankDetailView(viewModel: BankDetailViewModel(bankId: data.id))
            }
        
            
        }
    }
}
