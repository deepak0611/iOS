//
//  GameViewModel.swift
//  meeshoR1-swiftui
//
//  Created by Deepak Kumar1 on 01/09/25.
//
import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    
    @Published var currentLogoIndex: Int = 0
    var currentLogotextArray:[String] = []
    var logoData: [LogoModel] = []
    
    @Published var currentLetters: [Letters] = []
    @Published var jumbledLetters: [Letters] = []
    
    @Published var textToshow = ""
    @Published var gameOver = false
    
    var cancellables = Set<AnyCancellable>()
    init() {
        getLogoModelData()
//        getcurrentLetterArray()
//        getCurrentLogoLetters()
//        generateJumbledLetters()
        
        $currentLogoIndex
            .sink { [weak self] index in
                self?.getcurrentLetterArray(index: index)
                self?.getCurrentLogoLetters(index: index)
                self?.generateJumbledLetters(index: index)
            }
            .store(in: &cancellables)
    }
    
    func getcurrentLetterArray(index: Int) {
        let currentLogoText = logoData[index].name
        currentLogotextArray.removeAll()
        for letter in currentLogoText {
            currentLogotextArray.append(String(letter))
        }
    }
    
    func insertLetterToPlaceHolder(letter: Letters) {
        
        let index = currentLetters.firstIndex {
            $0.isMasked == true
        }
        
        let index2 = jumbledLetters.firstIndex(of: letter)
        
        let maskedData = currentLetters[index!]
        currentLetters[index!] = jumbledLetters[index2!]
        jumbledLetters[index2!] = maskedData
        
        checkForLogoCorrectness()
    }
    
    func swapLetters(letter: Letters) {
        print("hello")
        let index = currentLetters.firstIndex(of: letter)
        var id = letter.index
        var letterToReplace = jumbledLetters[id]
        jumbledLetters[id] = letter
        
        currentLetters[index!] = letterToReplace
        
    }
    
    func checkForLogoCorrectness() {
        let currentLogoText = logoData[currentLogoIndex].name
        var isCiorrect = true
        for i in 0..<currentLogotextArray.count {
            if currentLogotextArray[i] != currentLetters[i].value || currentLetters[i].isMasked == true {
                isCiorrect = false
            }
        }
        
        if isCiorrect {
            moveToNextLogo()
        }
    }
    
    func moveToNextLogo() {
        if(currentLogoIndex == logoData.count - 1) {
            textToshow = "Success! You have completed the game"
            gameOver = true
        } else {
            textToshow = "Correct, You have solved it correctly"
            currentLogoIndex = currentLogoIndex + 1
        }
        
        print("\(currentLogoIndex)")
    }
    
    func restartGame() {
        currentLogoIndex = 0
        gameOver = false
    }
    
    private func getCurrentLogoLetters(index: Int) {
        let currentLogoText = logoData[index].name
        currentLetters.removeAll()
        for letter in currentLogoText {
            currentLetters.append(Letters(id: UUID(), value: String(letter), isMasked: true, index: -1))
        }
            
    }
    
    private func generateJumbledLetters(index: Int) {
        let currentLogoText = logoData[index].name
        jumbledLetters.removeAll()
        var randomNumber = Int.random(in: 0...25)
        var id = 0
        for letter in currentLogoText {
            jumbledLetters.append(Letters(id: UUID(), value: String(letter), isMasked: false, index: id))
            id += 1
        }
            
        for i in currentLogoText.count...20 {
            let str = "A"
            jumbledLetters.append(Letters(id: UUID(), value: str, isMasked: false, index: id))
            id += 1
        }
        
    }
    
    private func getLogoModelData() {
        
        let jsonData = """
  [
    {
      "imgUrl": "meesho_logo",
      "name": "MEESHO"
    },
    {
      "imgUrl": "adhar_logo",
      "name": "AADHAAR"
    },
    {
      "imgUrl": "bhim_logo",
      "name": "BHIM"
    }
  ]
""".data(using: .utf8)
        
        do {
            let data = try JSONDecoder().decode([LogoModel].self, from: jsonData!)
            logoData = data
        } catch {
            debugPrint("error occured in decodig model")
        }
        
        
    }
    
}
