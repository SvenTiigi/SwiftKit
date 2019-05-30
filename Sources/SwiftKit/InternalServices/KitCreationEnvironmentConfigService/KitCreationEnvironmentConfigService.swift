//
//  KitCreationEnvironmentConfigService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 30.05.19.
//

import Foundation

// MARK: - KitCreationEnvironmentConfigService

/// The KitCreationEnvironmentConfigService
protocol KitCreationEnvironmentConfigService {
    
    /// Get KitCreationEnvironmentConfig
    ///
    /// - Returns: The KitCreationEnvironmentConfig
    /// - Throws: If retrieving fails
    func get() throws -> KitCreationEnvironmentConfig
    
}
