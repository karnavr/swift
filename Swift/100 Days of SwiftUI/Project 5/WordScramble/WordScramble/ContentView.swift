//
//  ContentView.swift
//  WordScramble
//
//  Created by Karnav Raval on 2021-05-31.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var currentScore: Int {
        // computes the current score as a rolling sum of the total number of letters used to create new words
        
        var score = 0
        
        for i in (0..<usedWords.count) {
            score += usedWords[i].count
        }
        
        return score
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                .cornerRadius(20)
                .padding(.vertical)
                
                
                HStack(spacing: 20) {
                    Text("Score:")
                        .font(.title2)
                        .bold()
                    Text("\(currentScore)")
                        .fontWeight(.bold)
                        .font(.largeTitle)
//                        .frame(width: 40, height: 50, alignment: .center)
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
                }
                
                    
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarItems(trailing: Button(action: startGame) {
                Text("restart")
            })
            
            
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {
            return
        }
        
        guard answer.count > 2 else {
            wordError(title: "Too short", message: "Your word needs to be 3 letter or longer!")
            return
        }
        
        guard answer != rootWord else {
            wordError(title: "Nice try..", message: "You cannot use the same word as the one given to you!")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame() {
        
        usedWords.removeAll()
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        // returns true if the word has not been spelled before and false if the word is being used again
        return !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        // checks if the spelled word is a possible/valid word to spell from the letters avaliable to use (with no repeats)
        var tempWord = rootWord.lowercased()
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        // checks if the input word is spelled correctly and returns true if so and returns false if word is misspelled
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// next steps: add an "i" button next to the score, that presents a full-screen modal explaing how the score is computed (also come up with a better scoring system other than simply adding the number of letters used in the created words haha)
