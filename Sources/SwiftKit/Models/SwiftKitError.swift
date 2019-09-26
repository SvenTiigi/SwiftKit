//
//  SwiftKitError.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - SwiftKitError

/// The SwiftKitError
public struct SwiftKitError {
    
    // MARK: Properties
    
    /// The reason
    public let reason: String
    
    /// The Error
    public let error: Error?
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - reason: The reason
    ///   - error: The optional Error. Default value nil
    public init(reason: String, error: Error? = nil) {
        self.reason = reason
        self.error = error
    }
    
}

// MARK: - LocalizedError

extension SwiftKitError: LocalizedError {
    
    /// A localized message describing what error occurred
    public var errorDescription: String? {
        var description = "🆘 SwiftKit failed\n"
        description += .dividerLine
        description += "\nReason: \(self.reason)"
        if let error = self.error {
            description += "\nError: \(error)\n"
        }
        description += .dividerLine
        return description
    }
    
    /// The localized Description
    public var localizedDescription: String {
        return self.errorDescription ?? "Unknown error"
    }
    
}

// MARK: - CustomStringConvertible

extension SwiftKitError: CustomStringConvertible {
    
    /// A textual representation of this instance
    public var description: String {
        return self.localizedDescription
    }
    
}

// MARK: - CustomDebugStringConvertible

extension SwiftKitError: CustomDebugStringConvertible {
    
    /// A textual representation of this instance, suitable for debugging
    public var debugDescription: String {
        return self.localizedDescription
    }
    
}
