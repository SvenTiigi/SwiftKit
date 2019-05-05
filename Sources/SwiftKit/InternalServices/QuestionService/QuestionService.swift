//
//  QuestionService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation

// MARK: - QuestionService

/// The QuestionService
protocol QuestionService {
    
    /// Ask Question
    ///
    /// - Parameters:
    ///   - question: The Question that should be asked
    ///   - predefinedAnswer: The optional predefined answer
    /// - Returns: The answer
    func ask(_ question: Question, predefinedAnswer: String?) -> String
    
}

// MARK: - Convenience functions

extension QuestionService {
    
    /// Ask Question
    ///
    /// - Parameter question: The Question that should be asked
    /// - Returns: The answer
    func ask(_ question: Question) -> String {
        return self.ask(question, predefinedAnswer: nil)
    }
    
}
