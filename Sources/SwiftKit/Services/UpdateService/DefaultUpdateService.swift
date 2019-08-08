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
        guard case .available(let version)? = self.updateCheckService.check(version: self.currentVersion) else {
            // No update available print that latest version is installed
            self.executable.print(
                "You are running the latest version of SwiftKit 📦 \(self.currentVersion.description)"
            )
            return
        }
        // Verify PackageManager is available
        guard let packageManager = self.packageManagerService.packageManager else {
            // Print out to update manually
            self.executable.print("Unable to detect PackageManager 🤷‍♂️")
            self.executable.print("Please update SwiftKit manually")
            // Return out of function
            return
        }
        // Start loading on Executable
        self.executable.startLoading(
            message: "Updating SwiftKit via \(packageManager.displayName) to version: \(version.description)"
        )
        // Update SwiftKit via PackageManager
        do {
            // Try to update PackageManagerService
            try self.packageManagerService.update(packageManager: packageManager)
        } catch {
            // Stop loading on Executable
            self.executable.stopLoading()
            // Print error
            self.executable.printError(
                SwiftKitError(reason: "SwiftKit update failed 🙈", error: error)
            )
            // Return out of function
            return
        }
        // Stop loading on Executable
        self.executable.stopLoading(message: "SwiftKit has been successfully updated 🚀")
    }
    
}
