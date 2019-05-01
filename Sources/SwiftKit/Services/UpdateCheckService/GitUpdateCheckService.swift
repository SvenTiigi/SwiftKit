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
    func check(version: String) -> UpdateResult? {
        // Verify latest Tag for repository URL is available
        guard let latestTag = self.gitService.getLatestTag(repositoryURL: self.repositoryURL) else {
            // Latest Tag is unavailable return nil
            return nil
        }
        // Initialize Latest Tag Version
        let latestTagVersion = Version(version: latestTag)
        // Initialize Version
        let version = Version(version: version)
        // Check if latest Tag and version are identical
        if latestTagVersion > version {
            // The latest tag is greater return available
            return .available(version: latestTag)
        } else {
            // Return latest
            return .latest
        }
    }
    
}

/// The Version
private struct Version: Codable, Equatable {
    
    /// The major version
    let major: Int
    
    /// The minor version
    let minor: Int
    
    /// The patch version
    let patch: Int
    
    /// Default initializer
    ///
    /// - Parameters:
    ///   - version: The Version string
    init(version: String) {
        let values = version.components(separatedBy: ".").compactMap(Int.init)
        self.major = values.indices.contains(0) ? values[0] : 0
        self.minor = values.indices.contains(1) ? values[1] : 0
        self.patch = values.indices.contains(2) ? values[2] : 0
    }
    
}

// MARK: - Version+Comparable

extension Version: Comparable {
    
    /// Returns a Boolean value indicating whether the value of the first
    public static func < (lhs: Version, rhs: Version) -> Bool {
        let sum: (Version) -> Int = { $0.major * 100 + $0.minor * 10 + $0.patch }
        return sum(lhs) < sum(rhs)
    }
    
}
