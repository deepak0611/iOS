//
//  TimerView.swift
//  zomatoR1-swiftui
//
//  Created by Deepak Kumar1 on 07/08/25.
//
import SwiftUI
struct TimerView: View {
    @StateObject var viewModel = TimerViewModel()
    var body: some View {
        VStack {
            Text("\(viewModel.textToShow)")
        }
    }
    
}
