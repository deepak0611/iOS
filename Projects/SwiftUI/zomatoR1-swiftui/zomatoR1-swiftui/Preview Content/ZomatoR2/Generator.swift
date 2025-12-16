//
//  Generator.swift
//  zomatoR1-swiftui
//
//  Created by Deepak Kumar1 on 07/08/25.
//
import SwiftUI

struct Generator: View {
    
    @StateObject var viewModel: GeneratorViewModel = GeneratorViewModel()
    
    var body: some View {
        
        
        VStack {
            Text("\(viewModel.dataToShow)")
            Button("Generate") {
                generateRandomNumber()
            }
            
            
            List(viewModel.data, id: \.self) { text in
                Text("\(text)")
            }
            
        }
        
    }
    
    func generateRandomNumber() {
        let num = Int.random(in: 1...100)
        viewModel.data.append(String(num))
        viewModel.updateLatestNumebr()
    }
}
