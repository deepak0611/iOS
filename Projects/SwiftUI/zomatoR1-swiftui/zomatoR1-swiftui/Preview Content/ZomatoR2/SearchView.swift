//
//  SearchView.swift
//  zomatoR1-swiftui
//
//  Created by Deepak Kumar1 on 07/08/25.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText = ""
    @ObservedObject var viewModel: SearchViewModel
   
    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .textInputAutocapitalization(.never)
                .onChange(of: searchText) { oldValue, newValue in
                    viewModel.getSearrchedData(with: newValue)
                }
            
            VStack {
                List(viewModel.listData, id: \.self) { data in
                    
                    Text("\(data)")
                }
            }
            
        }
    }

}

#Preview {
    SearchView(searchText: "", viewModel: SearchViewModel())
}
