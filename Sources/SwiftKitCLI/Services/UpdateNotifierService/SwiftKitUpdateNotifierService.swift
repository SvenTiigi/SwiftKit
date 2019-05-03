//
//  SwiftKitUpdateNotifierService.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 03.05.19.
//

import Foundation
import SwiftCLI
import SwiftKit

// MARK: - SwiftKitUpdateNotifierService

/// The SwiftKitUpdateNotifierService
struct SwiftKitUpdateNotifierService {
    
    /// The current Version
    let currentVersion: Version
    
    /// The UpdateCheckService
    let updateCheckService: UpdateCheckService
    
}

// MARK: - UpdateNotifierService

extension SwiftKitUpdateNotifierService: UpdateNotifierService {
    
    /// Notify about an available update
    ///
    /// - Parameter command: The Command
    func notifyIfNeeded(on command: Command) {
        // Check if an Update is available
        if case let .some(.available(version)) = self.updateCheckService.check(version: self.currentVersion) {
            // Print out that a new version is available
            command.stdout <<< "\nA new version of SwiftKit is available: \(version)"
            // Print out update instructions
            command.stdout <<< "To update SwiftKit run: swiftkit update"
        }
    }
    
}
