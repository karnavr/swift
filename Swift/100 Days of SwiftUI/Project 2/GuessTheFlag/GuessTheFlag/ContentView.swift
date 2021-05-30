//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Karnav Raval on 2021-05-26.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    @State private var totalScore = 0
    
    var body: some View {
        NavigationView {
            ZStack {
//                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
//
//                Color(.white).edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    VStack {
//                        Text("Tap the flag of")
//                        Spacer()
                        Text(countries[correctAnswer])
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    
                    ForEach(0..<3) { number in
                        Button(action: {
                            self.flagTapped(number)
                            showingScore = true
                        }) {
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                                .shadow(color: .black, radius: 2)
                        }
                    }
                    
                    Spacer()
                    HStack(spacing: 15) {
                        Text("Score:")
                        Text("\(totalScore)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    
                    
                    Button(action: {totalScore = 0}, label: {
                        Text("Reset score")
                            .fontWeight(.bold)
                            .textCase(.uppercase)
                            .font(.subheadline)
                            .padding(.all, 12)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .clipShape(Capsule())
                    })
                    
                    
                }
                .padding(40)
                
            }
            .navigationTitle("Guess the Flag")
            
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("Continue")) {
                        self.askQuestion()
                      })
            }
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            alertMessage = "Good job!"
            totalScore += 1
        } else {
            scoreTitle = "False"
            alertMessage = "Oops! That is actually \(countries[number])'s flag!"
            
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}

// Next Steps:
// - better the design (tweak spacing of the UI elements, better background colour, etc.)
// - add a button for resetting the score
// - tell the player what the correct answer is when they get it wrong
// - tell the player what country's flag they tapped when they get it wrong
// - add a heading/title of the game
// - only show alert if the question was answered wrong
