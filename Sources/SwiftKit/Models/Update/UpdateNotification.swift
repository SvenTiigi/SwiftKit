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
    
    init?(updateResult: UpdateResult) {
        guard case .available(let version) = updateResult else {
            return nil
        }
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
