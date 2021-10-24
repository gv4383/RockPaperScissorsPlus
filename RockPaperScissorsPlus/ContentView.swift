//
//  ContentView.swift
//  RockPaperScissorsPlus
//
//  Created by Goyo Vargas on 10/18/21.
//

import SwiftUI

struct Title: ViewModifier {
    let useSecondaryColor: Bool
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(useSecondaryColor ? .white : .black)
            .font(.largeTitle)
    }
}

extension View {
    func titleStyle (useSecondaryColor: Bool) -> some View {
        self.modifier(Title(useSecondaryColor: useSecondaryColor))
    }
}

struct TitleText: View {
    let text: String
    let useSecondaryColor: Bool
    
    var body: some View {
        Text("\(text)")
            .fontWeight(.black)
            .titleStyle(useSecondaryColor: useSecondaryColor)
    }
}

struct ContentView: View {
    @State private var moves = [
        "Rock",
        "Paper",
        "Scissors"
    ]
    @State private var outcome = [
        "Lose",
        "Win"
    ]
    @State private var selectedComputerMove = Int.random(in: 0...2)
    @State private var desiredOutcome = Int.random(in: 0...1)
    @State private var showResults = false
    @State private var didWin = 0
    @State private var resultsDescription = ""
    @State private var playerPoints = 0
    @State private var round = 0
    @State private var totalRounds = 5
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .pink]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                TitleText(text: "Points: \(playerPoints)", useSecondaryColor: false)
                
                TitleText(text: "\(outcome[desiredOutcome])", useSecondaryColor: true)
                
                TitleText(text: "against", useSecondaryColor: false)
                
                TitleText(text: "\(moves[selectedComputerMove]):", useSecondaryColor: true)
                
                ForEach(0..<moves.count) { move in
                    Button(action: {
                        self.moveTapped(move)
                    }) {
                        Text("\(moves[move])")
                            .padding()
                    }
                }
            }
            .alert(isPresented: $showResults) {
                Alert(
                    title: Text("Results"),
                    message: Text(resultsDescription),
                    dismissButton: .default(Text("Continue")) {
                        if round == totalRounds {
                            self.restartGame(totalReset: true)
                        } else {
                            self.restartGame(totalReset: false)
                        }
                    }
                )
            }
        }
    }
    
    func addMinusPoints(didWin: Int, desiredOutcome: Int) -> Void {
        if didWin == desiredOutcome {
            playerPoints += 1
        } else {
            playerPoints -= 1
        }
    }
    
    func moveTapped(_ move: Int) -> Void {
        print("You selected \(moves[move])!")
        round += 1
        showResults = true
        
        if moves[selectedComputerMove] == "Rock" {
            if moves[move] == "Rock" {
                didWin = 0
                resultsDescription = "You lost..."
                addMinusPoints(didWin: didWin, desiredOutcome: desiredOutcome)
            }
            
            if moves[move] == "Paper" {
                didWin = 1
                resultsDescription = "You won!"
                addMinusPoints(didWin: didWin, desiredOutcome: desiredOutcome)
            }
            
            if moves[move] == "Scissors" {
                didWin = 0
                resultsDescription = "You lost..."
                addMinusPoints(didWin: didWin, desiredOutcome: desiredOutcome)
            }
        }
        
        if moves[selectedComputerMove] == "Paper" {
            if moves[move] == "Rock" {
                didWin = 0
                resultsDescription = "You lost..."
                addMinusPoints(didWin: didWin, desiredOutcome: desiredOutcome)
            }
            
            if moves[move] == "Paper" {
                didWin = 0
                resultsDescription = "You lost..."
                addMinusPoints(didWin: didWin, desiredOutcome: desiredOutcome)
            }
            
            if moves[move] == "Scissors" {
                didWin = 1
                resultsDescription = "You won!"
                addMinusPoints(didWin: didWin, desiredOutcome: desiredOutcome)
            }
        }
        
        if moves[selectedComputerMove] == "Scissors" {
            if moves[move] == "Rock" {
                didWin = 1
                resultsDescription = "You won!"
                addMinusPoints(didWin: didWin, desiredOutcome: desiredOutcome)
            }
            
            if moves[move] == "Paper" {
                didWin = 0
                resultsDescription = "You lost..."
                addMinusPoints(didWin: didWin, desiredOutcome: desiredOutcome)
            }
            
            if moves[move] == "Scissors" {
                didWin = 0
                resultsDescription = "You lost..."
                addMinusPoints(didWin: didWin, desiredOutcome: desiredOutcome)
            }
        }
        
        if round == totalRounds {
            resultsDescription = "The game is over. Your final score is \(playerPoints)"
        }
    }
    
    func restartGame(totalReset: Bool) -> Void {
        if totalReset {
            playerPoints = 0
            round = 1
        }
        
        selectedComputerMove = Int.random(in: 0...2)
        desiredOutcome = Int.random(in: 0...1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
