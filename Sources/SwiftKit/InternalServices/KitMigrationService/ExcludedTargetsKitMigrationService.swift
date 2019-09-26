//
//  ExcludedTargetsKitMigrationService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 04.08.19.
//

import Foundation

// MARK: - ExcludedTargetsKitMigrationService

/// The ExcludedTargetsKitMigrationService
struct ExcludedTargetsKitMigrationService {
    
    /// The XcodeProjectService
    let xcodeProjectService: XcodeProjectService
    
}

// MARK: - KitMigrationService

extension ExcludedTargetsKitMigrationService: KitMigrationService {
    
    /// Migrate Kit at Directory
    ///
    /// - Parameters:
    ///   - kit: The Kit
    ///   - kitDirectory: The Kit Directory
    func migrate(kit: Kit, at kitDirectory: Kit.Directory) {
        // Initialize excluded Targets
        let excludedTargets = XcodeApplicationTarget.getExcludedTargets(
            includedTargets: kit.applicationTargets
        )
        // Check if excluded Targets are not empty
        if !excludedTargets.isEmpty {
            // Remove excluded ApplicationTargets from XcodeProject
            try? self.xcodeProjectService.remove(
                targets: excludedTargets,
                in: kitDirectory
            )
        }
    }
    
}
