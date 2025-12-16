//
//  SearchViewModel.swift
//  zomatoR1-swiftui
//
//  Created by Deepak Kumar1 on 07/08/25.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    
    @Published var listData = ["apple", "Banana", "Kiwi", "skdjgf", "sjdfgwi","wkejdb"]
    
    var searchWorkItem: DispatchWorkItem?
    
    init() {
        //empty init
    }
    
    func getSearrchedData(with text: String) {
        
        searchWorkItem?.cancel()
        
        searchWorkItem = DispatchWorkItem(block: { [weak self] in
            //network call
            print("api called: \(text)")
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                if(text == "apple") {
                    self?.listData = ["a", "b", "c"]
                }
                
                if(text == "banana") {
                    self?.listData = ["1", "2", "c"]
                }
            }
        })
        
        if let workItem = searchWorkItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: workItem)
        }
        
    }
    
    
}

