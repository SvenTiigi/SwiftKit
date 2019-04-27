//
//  BundleIdentifierQuestion.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - BundleIdentifierQuestion

/// The BundleIdentifierQuestion
struct BundleIdentifierQuestion {
    
    /// The Project Name
    let projectName: String
    
    /// The default BundleIdentifier
    var defaultBundleIdentifier: String {
        return "com.\(self.projectName)"
    }
    
}

// MARK: - Question

extension BundleIdentifierQuestion: Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant {
        return .optional(
            text: "📦 What's your Bundle Identifier?",
            hint: "Leave empty to use \(self.defaultBundleIdentifier)",
            defaultAnswer: self.defaultBundleIdentifier
        )
    }
    
}
