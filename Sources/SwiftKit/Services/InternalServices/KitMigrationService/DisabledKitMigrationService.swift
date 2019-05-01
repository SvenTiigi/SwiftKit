//
//  DisabledKitMigrationService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - DisabledKitMigrationService

/// The DisabledKitMigrationService
struct DisabledKitMigrationService: KitMigrationService {
    
    /// Migrate Kit at Directory
    ///
    /// - Parameters:
    ///   - kit: The Kit
    ///   - kitDirectory: The Kit Directory
    /// - Throws: If migration fails
    func migrate(kit: Kit, at kitDirectory: Kit.Directory) throws {
        // Simply do nothing
    }
    
}
