//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Karnav Raval on 2021-05-29.
//

import SwiftUI

struct ContentView: View {
    
    let possibleMoves = ["Rock", "Paper", "Scissors"]
    let symbolNames = ["capsule", "newspaper", "scissors"]
    let colors: [UIColor] = [.orange, .magenta, .blue, .cyan, .green, .purple, .red]
    
    @State private var shouldWin = true
    @State private var computerMove = 1
    @State private var currentMove: Int?
    @State private var score = 0
    @State private var gamesPlayed = 0
    @State private var gameEnded = false
    @State private var headerColor: UIColor = .orange
    
    
    var body: some View {
        VStack(spacing: 30) {
            
            ZStack {
                Color(headerColor).edgesIgnoringSafeArea(.top)
                    .frame(height: 80, alignment: .top)
                
                HStack(spacing: 30) {
                    Text("Score")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Text("\(score)")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title)
                }
                .frame(alignment: .leading)
            }
            
            Spacer()
            
            Text("computer's move:")
                .font(.footnote)
                .textCase(.uppercase)
            
            Image(systemName: symbolNames[computerMove])
                .font(.system(size: 120, weight: .semibold))
            
            Spacer()
            
            HStack {
                Text("try to")
                    .textCase(.uppercase)
                    .font(.footnote)
                
                shouldWin ? Text("WIN").font(.headline).foregroundColor(.green) : Text("LOSE").font(.headline).foregroundColor(.red)
            }
            
            Spacer()
            
            Text("Your move:")
                .font(.footnote)
                .textCase(.uppercase)
            
            HStack {
                ForEach(0 ..< 3) { i in
                    Button(action: {
                        currentMove = i
                        gamesPlayed += 1
                        updateScore(move: currentMove!, against: computerMove, condition: shouldWin)
                        if gamesPlayed == 10 { gameEnded = true }
                        resetBoard()

                    })
                    {
                        Image(systemName: symbolNames[i])
                            .foregroundColor(.black)
                            .font(.system(size: 50, weight: .semibold))
                        
                    }
                }
            }
            
            Spacer()
        }
        
        .alert(isPresented: $gameEnded) {
            Alert(title: Text("Game Ended"),
                  message: Text("Your score: \(score)/\(gamesPlayed)"), // display correct score
                  dismissButton: .default(Text("Play again")) {
                    resetBoard()
                    gamesPlayed = 0
                    score = 0
                    headerColor = colors.randomElement()!
                  })
        }
    }
    
    func updateScore(move: Int, against: Int, condition: Bool) -> Void {
        // reads the computer move and the player move, along with the objective of the player and determines if the player played successfully (true) or not (false) and updates the score accordinly
        
        var success: Bool = true
        
        // test for a win with normal rules
        if move == against {
            success = false  // this is technically a draw but can fix this later with optional output for this func, then the end card can also show tha number of draws
        } else if move == against + 1 {
            success = true
        } else if move == against - 2 {
            success = true
        } else {
            success = false
        }
        
        // see what the desired outcome was and change success accordingly
        if condition != true {
            success.toggle()
        }
        
        if success {
            score += 1
        } else {
            score += 0
        }
        
        return
    }
    
    func resetBoard() -> Void {
        // resets the board (choose new shouldWin and new computerMove) after each move by the player
        shouldWin = Bool.random()
        computerMove = Int.random(in: 0...2)
        return
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
