//
//  DefaultUpdateService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation

// MARK: - DefaultUpdateService

/// The DefaultUpdateService
struct DefaultUpdateService {
    
    /// The PackageManagerService
    let packageManagerService: PackageManagerService
    
    /// The UpdateCheckService
    let updateCheckService: UpdateCheckService
    
    /// The current Version
    let currentVersion: Version
    
    /// The Executable
    let executable: Executable
    
}

// MARK: - UpdateService

extension DefaultUpdateService: UpdateService {
    
    /// Perform Update
    func update() {
        // Verify update is available for current Version
        guard case .available(_)? = self.updateCheckService.check(version: self.currentVersion) else {
            // No update available print that latest version is installed
            self.executable.print(
                "You are running the latest version of SwiftKit 📦: \(self.currentVersion.description)"
            )
            return
        }
        // Verify PackageManager is available
        guard let packageManager = self.packageManagerService.packageManager else {
            // Print out to update manually
            self.executable.print("Unable to detect PackageManager 🤷‍♂️ Please update SwiftKit manually.")
            // Return out of function
            return
        }
        // Print updating via PackageManager
        self.executable.print("Updating SwiftKit via \(packageManager.displayName)")
        // Update SwiftKit via PackageManager
        do {
            try self.packageManagerService.update(packageManager: packageManager)
        } catch {
            // Print error
            self.executable.print(
                error: SwiftKitError(reason: "SwiftKit update failed 🙈", error: error)
            )
        }
    }
    
}
