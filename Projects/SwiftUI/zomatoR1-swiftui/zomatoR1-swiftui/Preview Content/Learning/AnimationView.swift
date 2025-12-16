//
//  Animation.swift
//  zomatoR1-swiftui
//
//  Created by Deepak Kumar1 on 07/08/25.
//
import SwiftUI

class AnimationViewModel: ObservableObject {
    @Published var count = 0
    var timer: Timer?
    var forward = true
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.incrementCounter()
        })
    }
    func incrementCounter() {
        if(count<3 && forward) {
            count += 1
        } else {
            forward = false
            count -= 1
            if(count==0) {
                forward = true
            }
        }
        
//        count = count % 4
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
}

struct AnimationView: View {
    @StateObject var viewModel = AnimationViewModel()
    let point1 = CGPoint(x: 50, y: 50)
    let point2 = CGPoint(x: 200, y: 50)
    let point3 = CGPoint(x: 50, y: 500)
    let point4 = CGPoint(x: 200, y: 500)
    var body: some View {
//        ZStack(alignment: .topLeading) {
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 100, height: 100)
//
//            Rectangle()
//                .fill(Color.blue)
//                .frame(width: 100, height: 100)
//
////            Color.red
//            
////            Text("top left")
////                .padding()
//        }
        
        GeometryReader { geometry in
            Rectangle()
                .fill(getColor())
                .animation(nil, value: viewModel.count)
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(getDegree()), anchor: .center)
                .position(getPoint())
                .animation(.easeInOut(duration: 1), value: viewModel.count)
                .onTapGesture {
                    viewModel.incrementCounter()
                }
        }
        
    }
    
    func getPoint() -> CGPoint {
        switch viewModel.count {
        case 0:
            return point1
        case 1:
            return point2
        case 2:
            return point3
        case 3:
            return point4
        default:
            return point1
        }
    }
    
    func getDegree() -> Double {
        switch viewModel.count {
        case 0:
            return 0
        case 1:
            return 45
        case 2:
            return 90
        case 3:
            return 135
        default:
            return 180
        }
    }
    
    func getColor() -> Color {
        switch viewModel.count {
        case 0:
            return Color.red
        case 1:
            return Color.blue
        case 2:
            return Color.green
        case 3:
            return Color.gray
        default:
            return Color.red
        }
    }
    
}
