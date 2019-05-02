//
//  Version.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 02.05.19.
//

import Foundation

// MARK: - Version

/// The Version
public struct Version: Codable, Equatable, Hashable {
    
    /// The major version
    public let major: Int
    
    /// The minor version
    public let minor: Int
    
    /// The patch version
    public let patch: Int
    
}

// MARK: - ExpressibleByStringLiteral

extension Version: ExpressibleByStringLiteral {
    
    /// Creates an instance initialized to the given string value.
    ///
    /// - Parameter value: The value of the new instance.
    public init(stringLiteral value: String) {
        let values = value.components(separatedBy: ".").compactMap(Int.init)
        self.major = values.indices.contains(0) ? values[0] : 0
        self.minor = values.indices.contains(1) ? values[1] : 0
        self.patch = values.indices.contains(2) ? values[2] : 0
    }
    
}

// MARK: - Comparable

extension Version: Comparable {
    
    /// Returns a Boolean value indicating whether the value of the first
    public static func < (lhs: Version, rhs: Version) -> Bool {
        let sum: (Version) -> Int = { $0.major * 100 + $0.minor * 10 + $0.patch }
        return sum(lhs) < sum(rhs)
    }
    
}

// MARK: - CustomStringConvertible

extension Version: CustomStringConvertible {
    
    /// A textual representation of this instance.
    public var description: String {
        return "\(self.major).\(self.minor).\(self.patch)"
    }
    
}
