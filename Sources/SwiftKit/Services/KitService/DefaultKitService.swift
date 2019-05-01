//
//  DefaultKitService.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - DefaultKitService

/// The DefaultKitService
struct DefaultKitService {
    
    /// The KitSetupService
    let kitSetupService: KitSetupService
    
    /// The KitMigrationService
    let kitMigrationService: KitMigrationService
    
}

// MARK: - KitService

extension DefaultKitService: KitService {
    
    /// Generate Kit at Directory
    ///
    /// - Parameters:
    ///   - kit: The Kit
    ///   - directory: The Kit Directory
    /// - Throws: If generating fails
    func generate(kit: Kit, at directory: Kit.Directory) throws {
        // Try to setup Kit at Directory
        try self.kitSetupService.setup(at: directory)
        // Try to migrate Kit at Directory
        try self.kitMigrationService.migrate(kit: kit, at: directory)
    }
    
}
