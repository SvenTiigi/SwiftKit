//
//  DefaultQuestionService.swift
//  Kit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation
import SwiftCLI

// MARK: - DefaultQuestionService

/// The DefaultQuestionService
struct DefaultQuestionService {}

// MARK: - QuestionService

extension DefaultQuestionService: QuestionService {
    
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
             defaultAnswer: (() -> String)?) -> String {
        
        
        
        return ""
    }
    
}
