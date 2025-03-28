//
//  QuizView.swift
//  Spelling
//
//  Created by Russell Gordon on 2023-10-30.
//

import SwiftUI

struct QuizView: View {
    
    // MARK: Stored properties
    
    // What the user is supposed to guess
    @State var currentItem = itemsToSpell.randomElement()!
    
    // What the user has guessed
    @State var userGuess = ""
    
    // What was the outcome of a user making a guess?
    @State var currentOutcome: Outcome = .undetermined
    
    // The list of previous results
    @State var history: [Result] = [] // empty array
    
    // MARK: Computed properties
    var body: some View {
        
        HStack {
            
            // Left side
            VStack {
                Image(currentItem.imageName)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    TextField("Enter the name of the item", text: $userGuess)
                    
                    Text(currentOutcome.rawValue)
                }
                
                HStack {
                    
                    Button {
                        checkGuess()
                    } label: {
                        Text("Submit")
                    }
                    
                    Button {
                        newWord()
                    } label: {
                        Text("New word")
                    }
                    
                }
                
            }
            .padding()
            
            // Right side
            List(history) { currentResult in
                
                HStack {
                    
                    Image(currentResult.item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                    
                    Text(currentResult.guessProvided)
                    
                    Spacer()
                    
                    Text(currentResult.outcome.rawValue)
                    
                }
                    
            }
            
        }
            
    }
    
    // MARK: Function
    func checkGuess() {
        if userGuess == currentItem.word {
            currentOutcome = .correct
            print("Correct")
        } else {
            currentOutcome = .incorrect
            print("Incorrect")
        }
    }
    
    func newWord() {
        
        // Save the prior result
        history.insert(
            Result(
                item: currentItem,
                guessProvided: userGuess,
                outcome: currentOutcome
            ),
            at: 0
        )
        // DEBUG: What is in the array now?
        print(history)
        
        // Picks a new word
        currentItem = itemsToSpell.randomElement()!
        userGuess = ""
        currentOutcome = .undetermined
    }
    
}

#Preview {
    QuizView()
}
