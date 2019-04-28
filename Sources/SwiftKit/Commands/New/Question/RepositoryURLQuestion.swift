//
//  RepositoryURLQuestion.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - RepositoryURLQuestion

/// The RepositoryURLQuestion
struct RepositoryURLQuestion {
    
    /// The ProjectDirectory
    let projectDirectory: ProjectDirectory
    
    /// The GitConfigService
    let gitConfigService: GitConfigService
    
    /// The Project Name
    let projectName: String
    
    /// The Author Name
    let authorName: String
    
    /// The Git URL
    var gitURL: String? {
        return self.gitConfigService.getRemoteURL(
            repositoryPath: self.projectDirectory.path
        )
    }
    
    /// The Fallback URL
    var fallbackURL: String {
        return "https://github.com/\(authorName.replacingOccurrences(of: " ", with: ""))/\(self.projectName)"
    }
    
}

// MARK: - Question

extension RepositoryURLQuestion: Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant {
        return .optional(
            text: "🌎  The Repository URL which is used for Podspec?",
            hint: self.gitURL.flatMap { "Leave empty to use: \($0)" } ?? "You may leave this empty",
            defaultAnswer: self.gitURL ?? self.fallbackURL
        )
    }
    
}
