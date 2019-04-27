//
//  Question.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation
import SwiftCLI

// MARK: - Question

/// The Question
protocol Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant { get }
    
}

// MARK: - Question+Ask

extension Question {
    
    /// Ask Question on Command
    ///
    /// - Parameter command: The Command
    /// - Returns: The Answer
    func ask(on command: Command) -> String {
        // Declare Answer
        var answer: String?
        defer {
            // Check if answer is not nil
            if answer != nil {
                // Print line
                command.stdout <<< ""
            }
        }
        // Switch on QuestionVariant
        switch self.questionVariant {
        case .required(let text):
            // Print Question text
            command.stdout <<< text
            // Verify answer is available
            guard let requiredAnswer = readLine()?.nonEmpty else {
                // Print Information is required
                command.stdout <<< "👮‍♂️ Information is required"
                // Re-Invoke ask
                return self.ask(on: command)
            }
            // Fill in required Answer
            answer = requiredAnswer
            // Return answer
            return requiredAnswer
        case .optional(let text, let hint, let defaultAnswer):
            // Print Text with Hint
            command.stdout <<< "\(text)\n(\(hint))"
            // Initialize Answer
            answer = readLine()?.nonEmpty
            // Return answer otherwise the default answer
            return answer ?? defaultAnswer
        }
    }
    
}

// MARK: - QuestionVariant

/// The QuestionVariant
enum QuestionVariant {
    /// Required Question
    case required(text: String)
    /// Optioanl Question
    case optional(
        text: String,
        hint: String,
        defaultAnswer: String
    )
}
