//
//  TimerViewModel.swift
//  zomatoR1-swiftui
//
//  Created by Deepak Kumar1 on 07/08/25.
//
import SwiftUI

import Combine

class TimerViewModel: ObservableObject {
    
    @Published var textToShow = ""
    var timer: Timer?
    var z = 0
    var cancellables = Set<AnyCancellable>()
    
    var t2: AnyCancellable?
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { [weak self] _ in
            self?.z += 1
            self?.textToShow = String(self?.z ?? 0)
        })
        
        t2 = Timer.publish(every: 2, on: .main, in: .default)
            .autoconnect()
            .sink(receiveValue: { date in
                print(date.formatted(date: .abbreviated, time: .shortened))
            })
            
            
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
        t2?.cancel()
    }
    
}
