//
//  PackageManager.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - PackageManagerService

/// The PackageManagerService
protocol PackageManagerService {

    /// The PackageManager which was SwiftKit installed
    var packageManager: PackageManager? { get }
    
    /// Update SwiftKit via the given PackageManager
    ///
    /// - Parameter packageManager: The PackageManager
    /// - Throws: If updating fails
    func update(packageManager: PackageManager) throws
    
}

// MARK: - PackageManager

/// The PackageManager
enum PackageManager: String, Codable, Equatable, Hashable, CaseIterable {
    /// Mint
    case mint
    /// Brew
    case brew
    
    /// The display name
    var displayName: String {
        switch self {
        case .mint:
            return "Mint 🌱"
        case .brew:
            return "Homebrew 🍺"
        }
    }
}
