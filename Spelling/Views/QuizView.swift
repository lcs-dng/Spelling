//
//  QuizView.swift
//  Spelling
//
//  Created by Russell Gordon on 2023-10-30.
//

import SwiftUI

struct QuizView: View {
    
    // MARK: Stored properties
    
    @State var currentItem = itemsToSpell.randomElement()!
    
    @State var userGuess = ""
    
    @State var currentOutcome: Outcome = .undetermined
    
    @State var history: [Result] = []
    
    @State var selectedOutcomeFilter: Outcome = .undetermined
    
    // MARK: Computed properties
    var body: some View {
        
        HStack {
            
            // Guess interface
            VStack {
                Image(currentItem.imageName)
                    .resizable()
                    .scaledToFit()
                
                HStack {
                    TextField("Enter the name of the item", text: $userGuess)
                        .padding(.horizontal)
                        .onKeyPress(.return) {
                            checkGuess()
                            return .handled
                        }
                    // Cannot type in text field once guess given
                        .disabled(currentOutcome != .undetermined)
                    
                    Text(currentOutcome.rawValue)
                        .frame(width: 20)
                }
                .padding()
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        newWord()
                    }, label: {
                        Text("New word")
                    })
                    // Disabled until a guess is given
                    .disabled(currentOutcome == .undetermined)
                    
                    Button(action: {
                        checkGuess()
                    }, label: {
                        Text("Submit")
                    })
                    // Cannot check guess a second time
                    .disabled(currentOutcome != .undetermined)
                    // Cannot check guess when guess is blank
                    .disabled(userGuess == "")
                    
                }
                .padding()
                
            }
            
            // Results interface
            VStack {
                
                Picker("Filtering on", selection: $selectedOutcomeFilter) {
                    Text("All results").tag(Outcome.undetermined)
                    Text("Correct").tag(Outcome.correct)
                    Text("Incorrect").tag(Outcome.incorrect)
                }
                .padding()
                
                List {
                    ScrollViewReader { scrollViewProxy in
                        let filteredList = filtering(
                            originalList: history,
                            on: selectedOutcomeFilter
                        )
                        ForEach(filteredList) { currentResult in
                            HStack {
                                Image(currentResult.item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 50)
                                
                                Text(currentResult.guessProvided)
                                
                                Spacer()
                                
                                Text(currentResult.outcome.rawValue)
                            }
                            .id(currentResult.id)
                        }
                        .onAppear {
                            scrollViewProxy.scrollTo(filteredList.first?.id)
                        }
                    }
                    
                }

            }
            
        }
        
        
    }
    
    // MARK: Functions
    func checkGuess() {
        if userGuess == currentItem.word {
            print("Correct")
            currentOutcome = .correct
        } else {
            print("Incorrect")
            currentOutcome = .incorrect
        }
    }
    
    func newWord() {
        
        // Add the current result to the history
        history.insert(
            Result(
                item: currentItem,
                guessProvided: userGuess,
                outcome: currentOutcome
            ),
            at: 0)
        
        // Reset quiz page
        userGuess = ""
        currentItem = itemsToSpell.randomElement()!
        currentOutcome = .undetermined
    }
    
}

#Preview {
    QuizView()
}
