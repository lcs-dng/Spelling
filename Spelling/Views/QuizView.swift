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
    
    // MARK: Computed properties
    var body: some View {
        
        VStack {
            Image(currentItem.imageName)
                .resizable()
                .scaledToFit()
            
            TextField("Enter the name of the item", text: $userGuess)
            
            Button {
                checkGuess()
            } label: {
                Text("Submit")
            }

        }
        
    }
    
    // MARK: Function
    func checkGuess() {
        if userGuess == currentItem.word {
            print("Correct")
        } else {
            print("Incorrect")
        }
    }
    
}

#Preview {
    QuizView()
}
