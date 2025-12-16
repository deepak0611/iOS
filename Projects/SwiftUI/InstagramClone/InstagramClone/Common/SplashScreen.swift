//
//  SplashScreen.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 08/08/25.
//

import SwiftUI

class SplashScreenViewModel: ObservableObject {
    var timer: Timer?
    var offset = 100
    
    let appNameLetters = [AnimatedTextModel(text: "I", initialOffset: 400),
                          AnimatedTextModel(text: "N", initialOffset: 500),
                          AnimatedTextModel(text: "S", initialOffset: 600),
                          AnimatedTextModel(text: "T", initialOffset: 700),
                          AnimatedTextModel(text: "A", initialOffset: 800),
                          AnimatedTextModel(text: "G", initialOffset: 900),
                          AnimatedTextModel(text: "R", initialOffset: 1000),
                          AnimatedTextModel(text: "A", initialOffset:1100),
                          AnimatedTextModel(text: "M", initialOffset: 1200),
    ]
    
    @Published var angle: Double = 0
    @Published var val2 = false
    @Published var toBold = false
    @Published var navigateToMainView = false
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.angle += 45
            if(self.angle > 1500 && self.angle.truncatingRemainder(dividingBy: 360) == 0) {
                self.timer?.invalidate()
                self.toBold = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                    withAnimation(.smooth) {
                        self.navigateToMainView = true
                    }
                }
            }
            
            if(self.val2==false) {
                self.val2 = true
            }
        }
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
}

struct AnimatedTextModel: Hashable {
    let text: String
    let initialOffset: CGFloat
}

struct SplashScreen: View {
    @StateObject var viewModel = SplashScreenViewModel()
    @State var logoAppearing = false
    
    var body: some View {
        
        if(viewModel.navigateToMainView) {
            MainTabView()
                .transition(.slide)
        } else {
            VStack {
                Image(systemName: "book.fill")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(Color.red)
                    .padding(.bottom, 32)
                    .opacity(logoAppearing ? 1 : 0)
                    .scaleEffect(logoAppearing ? 1 : 0)
                    .animation(.easeInOut(duration: 3), value: logoAppearing)
                    .onAppear {
                        logoAppearing = true
                    }
                
                HStack(spacing: 12) {
                    ForEach(viewModel.appNameLetters, id: \.self) { model in
                        Text("\(model.text)")
                            .rotationEffect(Angle(degrees: viewModel.angle))
                            .offset(x: viewModel.val2 ? 0: model.initialOffset)
                            .font(.largeTitle)
                            .animation(.easeInOut(duration: 3), value: viewModel.val2)
                            .bold(viewModel.toBold)
                            .foregroundStyle(viewModel.toBold ? Color.red : Color.black)
                            .animation(.easeInOut(duration: 1), value: viewModel.toBold)
                    }
                }
                
                Label {
                    Text("Created by Deepak Kumar")
                        .font(.headline)
                        .foregroundStyle(Color.gray)
                } icon: {
                    Image(systemName: "rosette")
                        .renderingMode(.template)
                        .frame(width: 36, height: 36)
                        .tint(Color.gray)
                }
                .padding(.top, 16)
                .opacity(logoAppearing ? 1 : 0)
            }
            .transition(.opacity)
        }
        
        
    }
    
    
}
