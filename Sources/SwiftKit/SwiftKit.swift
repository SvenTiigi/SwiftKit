//
//  SwiftKit.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - SwiftKit

/// The SwiftKit
public struct SwiftKit {
    
    // MARK: Properties
    
    /// The SwiftKit repository URL
    public let url: String
    
    /// The Git Branch
    public let branch: GitBranch
    
    /// The Version
    public let version: Version
    
    /// The Executable
    let executable: Executable
    
    /// The Git URL
    var gitURL: String {
        return "\(self.url).git"
    }
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - url: The SwiftKit repository URL. Default value `https://github.com/SvenTiigi/SwiftKit`
    ///   - branch: The Git Branch. Default value `.master`
    ///   - version: The Version. Default value `.default`
    ///   - executable: The Executable
    public init(url: String = "https://github.com/SvenTiigi/SwiftKit",
                branch: GitBranch = .master,
                version: Version = .default,
                executable: Executable) {
        self.url = url
        self.branch = branch
        self.version = version
        self.executable = executable
    }
    
}

// MARK: - Version+Default

public extension Version {
    
    /// The default Version
    static var `default`: Version {
        return .init(
            major: 1,
            minor: 3,
            patch: 9
        )
    }
    
}
