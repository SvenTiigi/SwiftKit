//
//  GitUpdateCheckService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - GitUpdateCheckService

/// The GitUpdateCheckService
struct GitUpdateCheckService {
    
    /// The repository URL
    let repositoryURL: String
    
    /// The GitService
    let gitService: GitService
    
}

// MARK: - UpdateCheckService

extension GitUpdateCheckService: UpdateCheckService {
    
    /// Check for Updates
    ///
    /// - Parameter version: The current installed Version
    /// - Returns: An UpdateResult if available
    func check(version: Version) -> UpdateResult? {
        // Verify latest Tag for repository URL is available
        guard let latestTag = self.gitService.getLatestTag(repositoryURL: self.repositoryURL) else {
            // Latest Tag is unavailable return nil
            return nil
        }
        // Initialize Latest Tag Version
        let latestTagVersion = Version(stringLiteral: latestTag)
        // Check if latest Tag and version are identical
        if latestTagVersion > version {
            // The latest tag is greater return available
            return .available(version: latestTagVersion)
        } else {
            // Return latest
            return .latest
        }
    }
    
}
