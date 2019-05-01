//
//  AuthorEmailQuestion.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation
import SwiftKit

// MARK: - AuthorEmailQuestion

/// The AuthorEmailQuestion
struct AuthorEmailQuestion {
    
    /// The GitService
    let gitService: GitService
    
    /// The Git Email
    var gitEmail: String? {
        return self.gitService.getValue(forKey: "user.email")
    }
    
}

// MARK: - Question

extension AuthorEmailQuestion: Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant {
        return .optional(
            text: "📫  What's your email address which is used for Podspec?",
            hint: self.gitEmail.flatMap { "Leave empty to use: \($0)" } ?? "You may leave this empty",
            defaultAnswer: gitEmail ?? ""
        )
    }
    
}
