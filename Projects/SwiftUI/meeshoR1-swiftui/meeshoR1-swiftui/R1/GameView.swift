//
//  GameView.swift
//  meeshoR1-swiftui
//
//  Created by Deepak Kumar1 on 01/09/25.
//
import SwiftUI

struct GameView: View {
    
    @StateObject var viewModel: GameViewModel = GameViewModel()
    
    var body: some View {
        
        VStack {
//            AsyncImage(url: URL(string: viewModel.logoData[viewModel.currentLogoIndex].imgUrl))
//                .frame(width: 56, height: 56)
            
            Image("\(viewModel.logoData[viewModel.currentLogoIndex].imgUrl)")
                .resizable()
                .frame(width: 56, height: 56)
            
            
            Text("\(viewModel.textToshow)")
            
            Button {
                viewModel.restartGame()
            } label: {
                Text("Restart game")
            }
            .opacity(viewModel.gameOver ? 1 : 0)

            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.currentLetters, id: \.self) { letter in
                        getRectangularViewForPlaceholderPostion(letter: letter)
                    }
                }
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.jumbledLetters, id: \.self) { letter in
                        getRectangularViewForJumbledPostion(letter: letter)
                    }
                }
            }
            
        }
        
    }
    
    
    @ViewBuilder
    func getRectangularViewForJumbledPostion(letter: Letters) -> some View {
        if letter.isMasked == false {
            ZStack {
                Text(letter.value)
            }
            .frame(width: 24, height: 24)
            .background(Color.green)
            .onTapGesture {
                viewModel.insertLetterToPlaceHolder(letter: letter)
            }
        } else {
            Rectangle()
                .frame(width: 24, height: 24)
                .background(Color.gray)
        }
        
    }
    
    @ViewBuilder
    func getRectangularViewForPlaceholderPostion(letter: Letters) -> some View {
        if letter.isMasked == false {
            ZStack {
                Text(letter.value)
            }
            .frame(width: 24, height: 24)
            .background(Color.green)
            .onTapGesture {
                viewModel.swapLetters(letter: letter)
            }
        } else {
            Rectangle()
                .frame(width: 24, height: 24)
                .background(Color.gray)
        }
        
    }
    
}
