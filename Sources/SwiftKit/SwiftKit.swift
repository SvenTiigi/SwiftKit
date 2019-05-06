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
    
    /// The Version
    public let version: Version
    
    /// The Environment
    public let environment: Environment
    
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
    ///   - version: The Version. Default value `.default`
    ///   - environment: The Environment. Default value `.default`
    ///   - executable: The Executable
    public init(url: String = "https://github.com/SvenTiigi/SwiftKit",
                version: Version = .default,
                environment: Environment = .default,
                executable: Executable) {
        self.url = url
        self.version = version
        self.environment = environment
        self.executable = executable
    }
    
}
