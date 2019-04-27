//
//  QuestionService.swift
//  Kit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - QuestionService

/// The QuestionService
protocol QuestionService {
    
    /// Ask a question
    ///
    /// - Parameters:
    ///   - question: The question text
    ///   - hint: The optional hint text
    ///   - validation: The optional validation closure
    ///   - defaultAnswer: The optional default answer
    /// - Returns: The answer
    func ask(question: String,
             hint: String?,
             validation: ((String) -> Bool)?,
             defaultAnswer: (() -> String)?) -> String
    
}

// MARK: - QuestionService Convenience Functions

extension QuestionService {
    
    /// Ask a question
    ///
    /// - Parameters:
    ///   - question: The question text
    ///   - hint: The optional hint text. Default value `nil`
    /// - Returns: The answer
    func ask(question: String, hint: String? = nil) -> String {
        return self.ask(
            question: question,
            hint: hint,
            validation: nil,
            defaultAnswer: nil
        )
    }
    
}
