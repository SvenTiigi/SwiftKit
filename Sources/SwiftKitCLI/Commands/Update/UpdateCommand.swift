//
//  UpdateCommand.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation
import SwiftCLI
import SwiftKit

// MARK: - UpdateCommand

/// The UpdateCommand
final class UpdateCommand {
    
    // MARK: Properties
    
    /// The PackageManagerService
    let packageManagerService: PackageManagerService
    
    /// The UpdateCheckService
    let updateCheckService: UpdateCheckService
    
    /// The current Version
    let currentVersion: Version
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - packageManagerService: The PackageManagerService
    ///   - updateCheckService: The UpdateCheckService
    ///   - currentVersion: The current Version
    init(packageManagerService: PackageManagerService,
         updateCheckService: UpdateCheckService,
         currentVersion: Version) {
        self.packageManagerService = packageManagerService
        self.updateCheckService = updateCheckService
        self.currentVersion = currentVersion
    }
    
}

// MARK: - Command

extension UpdateCommand: Command {
    
    /// The name
    var name: String {
        return "update"
    }
    
    /// A concise description of what this command or group is
    var shortDescription: String {
        return "Update SwiftKit"
    }
    
    /// A longer description of how to use this command or group
    var longDescription: String {
        return self.shortDescription
    }
    
    /// Executes the command
    ///
    /// - Throws: CLI.Error if command cannot execute successfully
    func execute() throws {
        // Print out ASCII art
        stdout <<< .asciiArt
        // Verify update is available for current Version
        guard case .available(_)? = self.updateCheckService.check(version: self.currentVersion) else {
            // No update available print that latest version is installed
            stdout <<< "You are running the latest version of SwiftKit 📦: \(self.currentVersion.description)"
            return
        }
        // Verify PackageManager is available
        guard let packageManager = self.packageManagerService.packageManager else {
            // Print out to update manually
            stdout <<< "Unable to detect PackageManager 🤷‍♂️ Please update SwiftKit manually."
            // Return out of function
            return
        }
        // Print updating via PackageManager
        stdout <<< "Updating SwiftKit via \(packageManager.displayName)"
        // Update SwiftKit via PackageManager
        try self.packageManagerService.update(packageManager: packageManager)
    }
    
}
