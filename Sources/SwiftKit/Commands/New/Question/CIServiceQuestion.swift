//
//  CIServiceQuestion.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 29.04.19.
//

import Foundation

// MARK: - CIServiceQuestion

/// The CIServiceQuestion
struct CIServiceQuestion {}

// MARK: - Question

extension CIServiceQuestion: Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant {
        return .optional(
            text: "Which CI-Service should be used?\n\(CIService.optionText)",
            hint: "You may leave this empty",
            defaultAnswer: "0"
        )
    }
    
}

// MARK: - CIService+OptionText

private extension CIService {
    
    /// The option text
    static var optionText: String {
        return "1) Travis CI\n2) GitLab CI"
    }
    
}
