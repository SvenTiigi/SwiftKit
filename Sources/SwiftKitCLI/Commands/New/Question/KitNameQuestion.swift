//
//  KitNameQuestion.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation
import SwiftKit

// MARK: - KitNameQuestion

/// The KitNameQuestion
struct KitNameQuestion {
    
    /// The Kit Directory
    let kitDirectory: Kit.Directory
    
    /// The optional Kit name computed by the Kit Directory
    var kitName: String? {
        return self.kitDirectory.path
            .drop(suffix: "/")
            .components(separatedBy: "/")
            .last
    }
    
}

// MARK: - Question

extension KitNameQuestion: Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant {
        // Initialize Question Text
        let text = "🐣  What is the name of your Kit?"
        // Check if KitName is available
        if let kitName = self.kitName {
            // Return optional variant as we can provide a default answer
            return .optional(
                text: text,
                hint: "Leave empty to use: \(kitName)",
                defaultAnswer: kitName
            )
        } else {
            // Return required variant
            return .required(
                text: text
            )
        }
    }
    
}
