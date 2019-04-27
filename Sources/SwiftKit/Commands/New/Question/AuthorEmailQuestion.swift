//
//  AuthorEmailQuestion.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - AuthorEmailQuestion

/// The AuthorEmailQuestion
struct AuthorEmailQuestion {
    
    /// The GitConfigService
    let gitConfigService: GitConfigService
    
    /// The Git Email
    var gitEmail: String? {
        return self.gitConfigService.getValue(forKey: "user.email")
    }
    
}

// MARK: - Question

extension AuthorEmailQuestion: Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant {
        return .optional(
            text: "✉️ What's your email address which is used for Podspec?",
            hint: self.gitEmail.flatMap { "Leave empty to use: \($0)" } ?? "You may leave this empty",
            defaultAnswer: gitEmail ?? ""
        )
    }
    
}
