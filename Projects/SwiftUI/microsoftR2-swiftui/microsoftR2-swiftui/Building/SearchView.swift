//
//  SearchView.swift
//  microsoftR2-swiftui
//
//  Created by Deepak Kumar1 on 04/09/25.
//

import SwiftUI

struct SearchView: View {

    @ObservedObject var viewModel: SearchViewModel
    @State var searchText = ""
    var body: some View {
        
        
        VStack {
            TextField("Search", text: $searchText)
                .onChange(of: searchText) { oldValue, newValue in
                    viewModel.filterViewData(text: newValue)
                }
            
            List(viewModel.cityData, id: \.self) { city in
                
                
                Section {
                    ForEach(viewModel.getBuldingDataBasedOn(city: city), id: \.id) { data in
                        Text("\(data.name)")
                    }
                } header: {
                    Text("\(city)")
                }

                
               
            }
            
        }
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
}
