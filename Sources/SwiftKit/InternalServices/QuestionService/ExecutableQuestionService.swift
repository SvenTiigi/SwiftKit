//
//  ExecutableQuestionService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation

// MARK: - ExecutableQuestionService

/// The ExecutableQuestionService
struct ExecutableQuestionService {
    
    /// The Executable
    let executable: Executable
    
}

// MARK: - QuestionService

extension ExecutableQuestionService: QuestionService {
    
    /// Ask Question
    ///
    /// - Parameters:
    ///   - question: The Question that should be asked
    ///   - predefinedAnswer: The optional predefined answer
    /// - Returns: The answer
    func ask(_ question: Question, predefinedAnswer: String?) -> String {
        // Check if an predefined answer is available
        if let predefinedAnswer = predefinedAnswer {
            // Return predefined answer
            return predefinedAnswer
        }
        // Defer
        defer {
            // Print empty line
            self.executable.print("")
        }
        // Switch on QuestionVariant
        switch question.questionVariant {
        case .required(let text):
            // Print Question text
            self.executable.print(text)
            // Verify answer is available
            guard let answer = self.executable.readLine(prompt: ">") else {
                // Print Information is required
                self.executable.print("☝️ Information is required")
                // Re-Invoke ask
                return self.ask(question, predefinedAnswer: predefinedAnswer)
            }
            // Return answer
            return answer
        case .optional(let text, let hint, let defaultAnswer):
            // Print Text with Hint
            self.executable.print("\(text)\n(\(hint))")
            // Initialize Answer by reading line
            let answer = self.executable.readLine(prompt: ">")
            // Return answer otherwise the default answer
            return answer ?? defaultAnswer
        }
    }
    
}
