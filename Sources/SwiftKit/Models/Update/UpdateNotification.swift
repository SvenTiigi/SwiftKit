//
//  UpdateNotification.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 08.05.19.
//

import Foundation

// MARK: - UpdateNotification

/// The UpdateNotification
struct UpdateNotification {
    
    // MARK: Properties
    
    /// The new/latest update Version
    let updateVersion: Version
    
    // MARK: Initializer
    
    /// Optional Initializer
    /// Will return nil if UpdateResult isn't case available
    ///
    /// - Parameter updateResult: The UpdateResult
    init?(updateResult: UpdateResult) {
        // Verify an updatable Version is available
        guard case .available(let version) = updateResult else {
            // No updatable Version is available return nil
            return nil
        }
        // Set Version
        self.updateVersion = version
    }
    
}

// MARK: - Show

extension UpdateNotification {
    
    /// Show on Executable
    ///
    /// - Parameter executable: The Executable to print out Notification
    func show(on executable: Executable) {
        // Print out that a new version is available
        executable.print("\nA new version of SwiftKit is available: \(self.updateVersion.description)")
        // Print out update instructions
        executable.print("To update SwiftKit run: swiftkit update")
    }
    
}
