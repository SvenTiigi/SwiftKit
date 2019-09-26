//
//  KitMigrationService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - KitMigrationService

/// The KitMigrationService
protocol KitMigrationService {
    
    /// Migrate Kit at Directory
    ///
    /// - Parameters:
    ///   - kit: The Kit
    ///   - kitDirectory: The Kit Directory
    func migrate(kit: Kit, at kitDirectory: Kit.Directory)
    
}
