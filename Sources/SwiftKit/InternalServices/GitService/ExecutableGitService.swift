//
//  ExecutableGitService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - ExecutableGitService

/// The ExecutableGitService
struct ExecutableGitService {
    
    /// The SwiftKit URL
    let swiftKitURL: String
    
    /// The Executable
    let executable: Executable
    
}

// MARK: - GitConfigService

extension ExecutableGitService: GitService {
    
    /// Initialize Git Repository
    ///
    /// - Parameter repositoryPath: The repository path
    /// - Throws: If initialization fails
    func initialize(in repositoryPath: String) throws {
        try self.executable.execute("cd \(repositoryPath) && git init")
    }
    
    /// Retrieve value for GitConfigKey
    ///
    /// - Parameter key: The GitConfigKey
    /// - Returns: The corresponding value if available
    func getValue(for key: GitConfigKey) -> String? {
        return try? self.executable.execute("git config --global --get \(key.rawValue)")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Retrieve remote URL for Repository
    ///
    /// - Parameter repositoryPath: The repository path
    /// - Returns: The remot URL if available
    func getRemoteURL(repositoryPath: String) -> String? {
        return try? self.executable.execute("cd \(repositoryPath) && git remote get-url origin")
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
        guard let tagName = try? self.executable.execute(command) else {
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
        try self.executable.execute("git clone -b \(branch.name) \(url) '\(path)' -q")
    }
    
    /// Add Remote Origin URL
    ///
    /// - Parameters:
    ///   - url: The origin URL
    ///   - repositoryPath: The repository path
    /// - Throws: If adding failed
    func addRemote(origin url: String, in repositoryPath: String) throws {
        try self.executable.execute("cd \(repositoryPath) && git remote add origin \(repositoryPath)")
    }
    
    /// Stage all File in repository path
    ///
    /// - Parameter repositoryPath: The repository path
    /// - Throws: If staging fails
    func stageAll(in repositoryPath: String) throws {
        try self.executable.execute("cd \(repositoryPath) && git add .")
    }
    
    /// Commit with message
    ///
    /// - Parameters:
    ///   - message: The commit message
    ///   - repositoryPath: The repository path
    /// - Throws: If staging or committing fails
    func commit(message: String, in repositoryPath: String) throws {
        try self.executable.execute(
            "cd \(repositoryPath) && git commit -m \"\(message)\" -m \"\(self.swiftKitURL)\""
        )
    }
    
}
