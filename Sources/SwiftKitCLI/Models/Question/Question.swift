//
//  Question.swift
//  SwiftKitCLI
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
        // Defer
        defer {
            // Print empty line
            command.stdout <<< ""
        }
        // Switch on QuestionVariant
        switch self.questionVariant {
        case .required(let text):
            // Print Question text
            command.stdout <<< text
            // Verify answer is available
            guard let answer = Input.readLine(prompt: ">").nonEmpty else {
                // Print Information is required
                command.stdout <<< "👮‍♂️ Information is required"
                // Re-Invoke ask
                return self.ask(on: command)
            }
            // Return answer
            return answer
        case .optional(let text, let hint, let defaultAnswer):
            // Print Text with Hint
            command.stdout <<< "\(text)\n(\(hint))"
            // Initialize Answer by reading line
            let answer = Input.readLine(prompt: ">").nonEmpty
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
