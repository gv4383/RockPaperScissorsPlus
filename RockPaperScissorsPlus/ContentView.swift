//
//  ContentView.swift
//  RockPaperScissorsPlus
//
//  Created by Goyo Vargas on 10/18/21.
//

import SwiftUI

struct MoveButton: View {
    let moveName: String
    
    var body: some View {
        Button(action: {
            print("You selected \(moveName)!")
        }) {
            Text("\(moveName)")
                .padding()
        }
    }
}

struct ContentView: View {
    @State private var moves = [
        "Rock",
        "Paper",
        "Scissors"
    ]
    @State private var outcome = [
        "Win",
        "Lose"
    ]
    @State private var selectedComputerMove = Int.random(in: 0...2)
    @State private var desiredOutcome = Int.random(in: 0...1)
    @State private var showResults = false
    @State private var resultsDescription = ""
    
    var body: some View {
        VStack{
            Text("\(outcome[desiredOutcome])")
            
            Text("against")
            
            Text("\(moves[selectedComputerMove]):")
            
            ForEach(0..<moves.count) { move in
//                TODO: Figure out how to pass in functions
//                MoveButton(moveName: moves[move])
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
                title: Text("Test Title"),
                message: Text(resultsDescription),
                dismissButton: .default(Text("Continue")) {
                    self.restartGame()
                }
            )
        }
    }
    
    func moveTapped(_ move: Int) {
        print("You selected \(moves[move])!")
        resultsDescription = "Results!"
        showResults = true
    }
    
    func restartGame() {
        selectedComputerMove = Int.random(in: 0...2)
        desiredOutcome = Int.random(in: 0...1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
