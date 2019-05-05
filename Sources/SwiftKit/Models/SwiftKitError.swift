//
//  SwiftKitError.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - SwiftKitError

/// The SwiftKitError
struct SwiftKitError {
    
    /// The reason
    let reason: String
    
    /// The Error
    let error: Error?
    
}

// MARK: - LocalizedError

extension SwiftKitError: LocalizedError {
    
    /// A localized message describing what error occurred
    var errorDescription: String? {
        var description = "🆘 SwiftKit failed\n"
        description += .dividerLine
        description += "\nReason: \(self.reason)"
        if let error = self.error {
            description += "\nError: \(error.localizedDescription)\n"
        }
        description += .dividerLine
        return description
    }
    
    /// The localized Description
    var localizedDescription: String {
        return self.errorDescription ?? "Unknown error"
    }
    
}

// MARK: - CustomStringConvertible

extension SwiftKitError: CustomStringConvertible {
    
    /// A textual representation of this instance
    var description: String {
        return self.localizedDescription
    }
    
}

// MARK: - CustomDebugStringConvertible

extension SwiftKitError: CustomDebugStringConvertible {
    
    /// A textual representation of this instance, suitable for debugging
    var debugDescription: String {
        return self.localizedDescription
    }
    
}
