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
    
    /// The Kit Directory
    let kitDirectory: Kit.Directory
    
    /// The GitService
    let gitService: GitService
    
    /// The Kit Name
    let kitName: String
    
    /// The Author Name
    let authorName: String
    
    /// The Git URL
    var gitURL: String? {
        return self.gitService.getRemoteURL(
            repositoryPath: self.kitDirectory.path
        )
    }
    
    /// The Fallback URL
    var fallbackURL: String {
        return "https://github.com/\(self.authorName.replacingOccurrences(of: " ", with: ""))/\(self.kitName)"
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
