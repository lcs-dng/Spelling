//
//  Filter.swift
//  Spelling
//
//  Created by Dexter Ng on 2025-03-28.
//

import Foundation

// Inputs (parameters)
//      - the original list
//      - what outcome the user wants included
//        i.e.: undetermined (all results), incorrect, correct
//
// Outout:
//      - the filtered list
func filtering(
    originalList: [Result],
    on desiredOutcome: Outcome
) -> [Result] {
    
    // When the desired outcome is undetermined, just stop
    // and return the entire original list
    if desiredOutcome == .undetermined {
        return originalList
    }
    
    // Create an empty list to populate before returning
    var filteredHistory: [Result] = [] // empty
    
    // Iterate over the entire array
    for result in originalList {
        
        // Copy any results that match the desired outcome into the new list
        if result.outcome == desiredOutcome {
            filteredHistory.append(result)
        }
        
    }
    
    // Return only the filtered list
    return filteredHistory
    
}
