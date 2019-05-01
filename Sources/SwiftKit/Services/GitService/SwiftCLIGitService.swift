//
//  SwiftCLIGitService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation
import SwiftCLI

// MARK: - SwiftCLIGitService

/// The SwiftCLIGitService
struct SwiftCLIGitService {}

// MARK: - GitConfigService

extension SwiftCLIGitService: GitService {
    
    /// Retrieve config value for key
    ///
    /// - Parameter key: The config key
    /// - Returns: The corresponding value if available
    func getValue(forKey key: String) -> String? {
        return try? SwiftCLI.capture(bash: "git config --global --get \(key)")
            .stdout
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Retrieve remote URL for Repository
    ///
    /// - Parameter repositoryPath: The repository path
    /// - Returns: The remot URL if available
    func getRemoteURL(repositoryPath: String) -> String? {
        return try? SwiftCLI.capture(bash: "cd \(repositoryPath) && git remote get-url origin")
            .stdout
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .drop(suffix: ".git")
    }
    
    /// Clone Git Repo from URL to Path
    ///
    /// - Parameters:
    ///   - url: The Git Repo URL
    ///   - path: The Path where the cloned repo should be stored
    ///   - branch: The GitBranch
    /// - Throws: If cloning fails
    func clone(from url: String, to path: String, branch: GitBranch) throws {
        try SwiftCLI.run(bash: "git clone -b \(branch.name) \(url) '\(path)' -q")
    }
    
}
