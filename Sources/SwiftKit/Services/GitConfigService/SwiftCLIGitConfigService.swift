//
//  SwiftCLIGitConfigService.swift
//  Kit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation
import SwiftCLI

// MARK: - SwiftCLIGitConfigService

/// The SwiftCLIGitConfigService
struct SwiftCLIGitConfigService {}

// MARK: - GitConfigService

extension SwiftCLIGitConfigService: GitConfigService {
    
    /// Retrieve config value for key
    ///
    /// - Parameter key: The config key
    /// - Returns: The corresponding value if available
    func getValue(forKey key: String) -> String? {
        return try? capture(bash: "git config --global --get \(key)")
            .stdout
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Retrieve remote URL for Repository
    ///
    /// - Parameter repositoryPath: The repository path
    /// - Returns: The remot URL if available
    func getRemoteURL(repositoryPath: String) -> String? {
        return try? capture(bash: "cd \(repositoryPath) && git remote get-url origin")
            .stdout
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .drop(suffix: ".git")
    }
    
}
