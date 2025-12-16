//
//  SelectTeamView.swift
//  worldT20-FlipkartMC-DeepakKumar
//
//  Created by Deepak Kumar1 on 27/07/25.
//

import SwiftUI


struct SelectTeamView: View {
    
    @StateObject var viewModel: SelectTeamViewModel = SelectTeamViewModel()
    @State private var selectedItems: [Team] = []
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                VStack(alignment: .leading) {
                    List(viewModel.teams) { item in
                        HStack {
                            AsyncImage(url: URL(string: item.flag), scale: 1)
                                .frame(width: 36, height: 36, alignment: .center)
                            Text(item.name)
                            Spacer()
                        }
                        .padding(.zero)
                        .frame(maxWidth: .infinity)
                        .background(selectedItems.contains(item) ? Color.green.opacity(0.5) : .clear)
                        .onTapGesture {
                            toggleSelection(of: item)
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(Visibility.hidden)
                    }
                    .listStyle(GroupedListStyle())
                    .padding(.zero)
                }
                Spacer()
                Button {
                    path.append(selectedItems)
                } label: {
                    Text("Start Match")
                        .frame(maxWidth: .infinity)
                        .tint(Color.white)
                        .foregroundStyle(Color.white)
                }
                .background(selectedItems.count != 2 ? Color.gray : Color.green)
                .disabled(selectedItems.count != 2)
                
                
            }
            
            .navigationTitle("Select Team")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: [Team].self) { selectedItems in
                MatchCenterView(viewModel: MatchCenterViewModel(team1Name: selectedItems[0].name, team2Name: selectedItems[1].name))
            }
        }
    }
    
    
    
    private func toggleSelection(of item: Team) {
        if selectedItems.contains(item) {
            if let index = selectedItems.firstIndex(of: item) {
                selectedItems.remove(at: index)
            }
        } else {
            if selectedItems.count < 2 {
                selectedItems.append(item)
            } else {
                print("Limit reached")
            }
        }
    }
}
