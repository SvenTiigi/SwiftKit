//
//  SwiftKit+Environment.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - Environment

public extension SwiftKit {
    
    /// The Environment
    enum Environment: String, Codable, Equatable, Hashable, CaseIterable {
        /// The Production Environment
        case production
        /// The Development Environment
        case development
        /// The Test Environment
        case test
    }
    
}

// MARK: - Environment+Default

public extension SwiftKit.Environment {
    
    /// The default Environment
    static var `default`: SwiftKit.Environment {
        return .production
    }
    
}

// MARK: - Version+Default

public extension Version {
    
    /// The default Version
    static var `default`: Version {
        return .init(
            major: 1,
            minor: 2,
            patch: 5
        )
    }
    
}
