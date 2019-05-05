//
//  AuthorNameQuestion.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - AuthorNameQuestion

/// The AuthorNameQuestion
struct AuthorNameQuestion {
    
    /// The GitService
    let gitService: GitService
    
    /// The Git Name
    var gitName: String? {
        return self.gitService.getValue(for: .name)
    }
    
}

// MARK: - Question

extension AuthorNameQuestion: Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant {
        let text = "👨‍💻  What's your name?"
        if let gitName = self.gitName {
            return .optional(
                text: text,
                hint: "Leave empty to use: \(gitName)",
                defaultAnswer: gitName
            )
        } else {
            return .required(text: text)
        }
    }
    
}
