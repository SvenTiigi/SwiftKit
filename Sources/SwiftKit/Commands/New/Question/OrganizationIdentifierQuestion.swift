//
//  BundleIdentifierQuestion.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - OrganizationIdentifierQuestion

/// The OrganizationIdentifierQuestion
struct OrganizationIdentifierQuestion {
    
    /// The Project Name
    let projectName: String
    
    /// The default Organization Identifier
    var defaultOrganizationIdentifier: String {
        return "\(Locale.current.topLevelDomain).\(self.projectName)"
    }
    
}

// MARK: - Question

extension OrganizationIdentifierQuestion: Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant {
        return .optional(
            text: "🖋   What's your organization identifier?",
            hint: "Leave empty to use \(self.defaultOrganizationIdentifier)",
            defaultAnswer: self.defaultOrganizationIdentifier
        )
    }
    
}

// MARK: - Locale+TopLevelDomain

private extension Locale {
    
    /// The default Top-Level-Domain
    var defaultTopLevelDomain: String {
        return "com"
    }
    
    /// The localized Top-Level-Domain
    var topLevelDomain: String {
        // Verify LanguageCode is available
        guard let languageCode = self.languageCode else {
            // Return default Top-Level-Domain
            return self.defaultTopLevelDomain
        }
        // Verify LanguageCode is not en
        guard languageCode != "en" else {
            // Return default Top-Level-Domain
            return self.defaultTopLevelDomain
        }
        // Return LanguageCode
        return languageCode
    }
    
}
