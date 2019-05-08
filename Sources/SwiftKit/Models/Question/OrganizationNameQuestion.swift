//
//  OrganizationNameQuestion.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - OrganizationNameQuestion

/// The OrganizationNameQuestion
struct OrganizationNameQuestion {
    
    /// The Kit name
    let kitName: String
    
}

// MARK: - Question

extension OrganizationNameQuestion: Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant {
        return .optional(
            text: "🏢  What's your organization name?",
            hint: "Leave empty to use: \(self.kitName)",
            defaultAnswer: self.kitName
        )
    }
    
}
