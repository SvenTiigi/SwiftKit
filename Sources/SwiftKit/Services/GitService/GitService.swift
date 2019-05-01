//
//  GitService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - GitService

/// The GitService
public protocol GitService {
    
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
    
}

// MARK: - GitConfigKey

/// The GitConfigKey
public enum GitConfigKey: String, Codable, Equatable, Hashable, CaseIterable {
    /// The name
    case name = "user.name"
    /// The email
    case email = "user.email"
}

// MARK: - GitBranch

/// The GitBranch
public enum GitBranch: Equatable, Hashable {
    /// Master Branch
    case master
    /// Develop Branch
    case develop
    /// Feature Branch
    case feature(name: String)
    /// HotFix Branch
    case hotfix(name: String)
    /// Custom Branch
    case custom(name: String)
    
    /// The Name
    public var name: String {
        switch self {
        case .master:
            return "master"
        case .develop:
            return "develop"
        case .feature(let name):
            return "feature/\(name)"
        case .hotfix(let name):
            return "hotfix/\(name)"
        case .custom(let customName):
            return customName
        }
    }
    
}
