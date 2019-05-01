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
    
    /// Retrieve value for GitConfigKey
    ///
    /// - Parameter key: The GitConfigKey
    /// - Returns: The corresponding value if available
    func getValue(for key: GitConfigKey) -> String? {
        return try? SwiftCLI.capture(bash: "git config --global --get \(key.rawValue)")
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
    
    /// Retrieve latest Tag from repository URL
    ///
    /// - Parameter repositoryURL: The repository URL
    /// - Returns: The latest Tag if available
    func getLatestTag(repositoryURL: String) -> String? {
        // Initialize curl command
        let command = #"""
        curl --silent "\#(repositoryURL)/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#'
        """#
        // Verify TagName is available
        guard let tagName = try? SwiftCLI.capture(bash: command).stdout else {
            return nil
        }
        // Return trimmed Tag Name
        return tagName.trimmingCharacters(in: CharacterSet(charactersIn: "01234567890.").inverted)
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
