//
//  KitCreationEnvironmentConfigService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 30.05.19.
//

import Foundation

// MARK: - KitCreationEnvironmentConfigService

/// The KitCreationEnvironmentConfigService
typealias KitCreationEnvironmentConfigService = ReadableKitCreationEnvironmentConfigService
    & WritableKitCreationEnvironmentConfigService

// MARK: - ReadableKitCreationEnvironmentConfigService

/// The ReadableKitCreationEnvironmentConfigService
protocol ReadableKitCreationEnvironmentConfigService {
    
    /// Get KitCreationEnvironmentConfig
    ///
    /// - Returns: The KitCreationEnvironmentConfig
    /// - Throws: If retrieving fails
    func get() throws -> KitCreationEnvironmentConfig
    
}

// MARK: - WritableKitCreationEnvironmentConfigService

/// The WritableKitCreationEnvironmentConfigService
protocol WritableKitCreationEnvironmentConfigService {
    
    /// Save KitCreationEnvironmentConfig
    ///
    /// - Parameter kitCreationEnvironmentConfig: The KitCreationEnvironmentConfig that should be saved
    /// - Throws: If saving fails
    func save(_ kitCreationEnvironmentConfig: KitCreationEnvironmentConfig) throws
    
}
