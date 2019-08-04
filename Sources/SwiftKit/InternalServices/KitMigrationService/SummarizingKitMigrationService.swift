//
//  SummarizingKitMigrationService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 26.05.19.
//

import Foundation

// MARK: - SummarizingKitMigrationService

/// The SummarizingKitMigrationService
struct SummarizingKitMigrationService {
    
    /// The KitMigrations
    let kitMigrations: [KitMigration]
    
}

// MARK: - KitMigrationService

extension SummarizingKitMigrationService: KitMigrationService {
    
    /// Migrate Kit at Directory
    ///
    /// - Parameters:
    ///   - kit: The Kit
    ///   - kitDirectory: The Kit Directory
    /// - Throws: If migration fails
    func migrate(kit: Kit, at kitDirectory: Kit.Directory) throws {
        // For each KitMigration
        for kitMigration in self.kitMigrations {
            // Initialize migrate Kit closure
            let migrateKit: () throws -> Void = {
                // Try to migrate Kit at Directory
                try kitMigration.service.migrate(
                    kit: kit,
                    at: kitDirectory
                )
            }
            // Check if discard error is enabled
            if kitMigration.discardError {
                // Migrate Kit and discard any Error
                _ = try? migrateKit()
            } else {
                // Try to Migrate Kit
                try migrateKit()
            }
        }
    }
    
}

// MARK: - KitMigration

extension SummarizingKitMigrationService {
    
    /// The KitMigration
    struct KitMigration {
        
        /// The KitMigrationService
        let service: KitMigrationService
        
        /// The discard error Bool
        let discardError: Bool
        
        /// Designated Initializer
        ///
        /// - Parameters:
        ///   - service: The KitMigrationService
        ///   - discardError: The discard error Bool. Default value `false`
        init(_ service: KitMigrationService, discardError: Bool = false) {
            self.service = service
            self.discardError = discardError
        }
        
    }
    
}
