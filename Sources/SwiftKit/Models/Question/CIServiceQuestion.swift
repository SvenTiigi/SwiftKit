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
            text: "🛠   Which CI-Service should be used?\n\(Kit.CIService.optionText)",
            hint: "Type in the number or leave this empty to use none of them",
            defaultAnswer: ""
        )
    }
    
}

// MARK: - Kit.CIService+OptionText

private extension Kit.CIService {
    
    /// The option text
    static var optionText: String {
        return self.allCases
            .map { "\($0.rawValue)) \($0.displayName)" }
            .joined(separator: "\n")
    }
    
}
