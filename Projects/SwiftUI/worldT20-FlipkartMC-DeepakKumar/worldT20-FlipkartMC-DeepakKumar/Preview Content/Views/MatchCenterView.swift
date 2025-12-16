//
//  MatchCenterView.swift
//  worldT20-FlipkartMC-DeepakKumar
//
//  Created by Deepak Kumar1 on 27/07/25.
//

import SwiftUI


struct MatchCenterView: View {
    
    @EnvironmentObject var theme: Theme
    @ObservedObject var viewModel: MatchCenterViewModel
    @State var battingTeamIndex: Int = 0
    @State var predictionVal: String = "Match not started"
    @State var buttontext: String = "Play Next ball"
    
    var body: some View {
            
            VStack {
                VStack(alignment: .leading) {
                    Text("\(viewModel.team1Name) \(battingTeamIndex==0 ? " (Batting)" : (battingTeamIndex==2 ? "" : " (Bowling)"))")
                        .font(.headline)
                    
                    HStack {
                        Text("Score: \(viewModel.teamScore[0].score)/\(viewModel.teamScore[0].wicket)")
                        Spacer()
                        Text("Overs: \(viewModel.teamScore[0].overs)")
                    }
                    
                    Text("\(viewModel.team2Name) \(battingTeamIndex==1 ? " (Batting)" : (battingTeamIndex==2 ? "" :" (Bowling)"))")
                        .font(.headline)
                    
                    HStack {
                        Text(battingTeamIndex==0 ? "yet to bat" : "Score: \(viewModel.teamScore[1].score)/\(viewModel.teamScore[1].wicket)")
                        Spacer()
                        Text(battingTeamIndex==0 ? "yet to bat" : "Overs: \(viewModel.teamScore[1].overs)")
                    }
                }
                
                ZStack {
                    Color.gray
                    
                    Text(predictionVal)
                        .font(.headline)
                }
                
                Spacer()
                
                Button(action: {
                    generateRandomScore()
                }) {
                    Text(buttontext)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding([.horizontal, .bottom])
                }
            }
            
            .navigationTitle("Match Center: \(theme.theme)")
    }
    
    func generateRandomScore() {
        if(battingTeamIndex==2){
            return
        }
        
        let prediction: [Int] = [0,1,2,3,4,6,7]
        
        let randomIndex =  Int.random(in: 0...6)
        let val = prediction[randomIndex]
        
        if(val==7) {
            viewModel.teamScore[battingTeamIndex].wicket += 1
            
            predictionVal = "Out"
        } else {
            viewModel.teamScore[battingTeamIndex].score += val
            predictionVal = "\(val)"
        }
        
        viewModel.teamScore[battingTeamIndex].balls += 1
        
        if(viewModel.teamScore[battingTeamIndex].balls==12 || viewModel.teamScore[battingTeamIndex].wicket==3 || (viewModel.teamScore[1].score>=viewModel.teamScore[0].score && battingTeamIndex==1)) {
            battingTeamIndex += 1
            predictionVal = battingTeamIndex == 1 ? "Inning change" : (viewModel.teamScore[0].score > viewModel.teamScore[1].score ? "\(viewModel.team1Name) Wins" : "\(viewModel.team2Name) Wins")
            if(battingTeamIndex == 2) {
                buttontext = "Match Over"
            }
        }
    }
    
    
}
