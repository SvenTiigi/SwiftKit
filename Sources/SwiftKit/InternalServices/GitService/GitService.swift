//
//  GitService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - GitService

/// The GitService
protocol GitService {
    
    /// Initialize Git Repository
    ///
    /// - Parameter repositoryPath: The repository path
    /// - Throws: If initialization fails
    func initialize(in repositoryPath: String) throws
    
    /// Retrieve value for GitConfigKey
    ///
    /// - Parameter key: The GitConfigKey
    /// - Returns: The corresponding value if available
    func getValue(for key: GitConfigKey) -> String?
    
    /// Retrieve remote URL for Repository
    ///
    /// - Parameter repositoryPath: The repository path
    /// - Returns: The remot URL if available
    func getRemoteURL(repositoryPath: String) -> String?
    
    /// Retrieve latest Tag from repository URL
    ///
    /// - Parameter repositoryURL: The repository URL
    /// - Returns: The latest Tag if available
    func getLatestTag(repositoryURL: String) -> String?
    
    /// Clone Git Repo from URL to Path
    ///
    /// - Parameters:
    ///   - url: The Git Repo URL
    ///   - path: The Path where the cloned repo should be stored
    ///   - branch: The GitBranch
    /// - Throws: If cloning fails
    func clone(from url: String, to path: String, branch: GitBranch) throws
    
    /// Add Remote Origin URL
    ///
    /// - Parameters:
    ///   - url: The origin URL
    ///   - repositoryPath: The repository path
    /// - Throws: If adding failed
    func addRemote(origin url: String, in repositoryPath: String) throws

    /// Stage all File in repository path
    ///
    /// - Parameter repositoryPath: The repository path
    /// - Throws: If staging fails
    func stageAll(in repositoryPath: String) throws
    
    /// Commit with message
    ///
    /// - Parameters:
    ///   - message: The commit message
    ///   - repositoryPath: The repository path
    /// - Throws: If staging or committing fails
    func commit(message: String, in repositoryPath: String) throws
    
}
