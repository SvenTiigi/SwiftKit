//
//  GenerateKitQuestion.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 03.05.19.
//

import Foundation

// MARK: - GenerateKitQuestion

/// The GenerateKitQuestion
struct GenerateKitQuestion {
    
    /// The Kit name
    let kitName: String

}

// MARK: - Question

extension GenerateKitQuestion: Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant {
        return .optional(
            text: "Generate \(self.kitName)? ✅",
            hint: "Simply hit enter or type N/n (no) to abort",
            defaultAnswer: "y"
        )
    }
    
}
