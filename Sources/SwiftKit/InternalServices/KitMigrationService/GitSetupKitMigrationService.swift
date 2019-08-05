//
//  GitSetupKitMigrationService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 04.08.19.
//

import Foundation

// MARK: - GitSetupKitMigrationService

/// The GitSetupKitMigrationService
struct GitSetupKitMigrationService {
    
    /// The GitService
    let gitService: GitService
    
}

// MARK: - KitMigrationService

extension GitSetupKitMigrationService: KitMigrationService {
    
    /// Migrate Kit at Directory
    ///
    /// - Parameters:
    ///   - kit: The Kit
    ///   - kitDirectory: The Kit Directory
    func migrate(kit: Kit, at kitDirectory: Kit.Directory) {
        // Initialize Git in Kit Directory
        try? self.gitService.initialize(in: kitDirectory.path.rawValue)
        // Stage all FIles
        try? self.gitService.stageAll(in: kitDirectory.path.rawValue)
        // Commit all in Kit Directory
        try? self.gitService.commit(
            message: "Setup \(kit.name) with SwiftKit 📦",
            in: kitDirectory.path.rawValue
        )
        // Add Remote origin
        try? self.gitService.addRemote(
            origin: kit.repositoryURL,
            in: kitDirectory.path.rawValue
        )
    }
    
}
