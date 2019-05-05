//
//  ExecutableUpdateNotifierService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation

// MARK: - ExecutableUpdateNotifierService

/// The ExecutableUpdateNotifierService
struct ExecutableUpdateNotifierService {
    
    /// The current Version
    let currentVersion: Version
    
    /// The UpdateCheckService
    let updateCheckService: UpdateCheckService
    
    /// The Executable
    let executable: Executable
    
}

// MARK: - UpdateNotifierService

extension ExecutableUpdateNotifierService: UpdateNotifierService {
    
    /// Notify about an available update if needed
    func notifyIfNeeded() {
        // Check if an Update is available
        if case let .some(.available(version)) = self.updateCheckService.check(version: self.currentVersion) {
            // Print out that a new version is available
            self.executable.print("\nA new version of SwiftKit is available: \(version)")
            // Print out update instructions
            self.executable.print("To update SwiftKit run: swiftkit update")
        }
    }
    
}
