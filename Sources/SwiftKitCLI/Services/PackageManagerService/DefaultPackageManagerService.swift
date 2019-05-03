//
//  DefaultPackageManagerService.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation
import SwiftCLI

// MARK: - DefaultPackageManagerService

/// The DefaultPackageManagerService
struct DefaultPackageManagerService {}

// MARK: - PackageManager

extension DefaultPackageManagerService: PackageManagerService {
    
    /// The PackageManager which was SwiftKit installed
    var packageManager: PackageManager? {
        // For each PackageManager
        for packageManager in PackageManager.allCases {
            // Retrieve PackageManager list
            guard let packageList = try? SwiftCLI.capture(bash: packageManager.listCommand).stdout else {
                // Continue with next PackageManager as list is unavailable
                continue
            }
            // Verify SwiftKit is contained in PackageList
            guard packageList.lowercased().contains("swiftkit") else {
                // SwiftKit is not contained continue with next PackageManager
                continue
            }
            // SwiftKit is contained in PackageList
            return packageManager
        }
        // No PackageManager found that lists SwiftKit
        return nil
    }
    
    /// Update SwiftKit via the given PackageManager
    ///
    /// - Parameter packageManager: The PackageManager
    /// - Throws: If updating fails
    func update(packageManager: PackageManager) throws {
        // Run update command
        try SwiftCLI.run(bash: packageManager.updateCommand)
    }
    
}

// MARK: - PackageManager+commands

private extension PackageManager {
    
    /// The list command
    var listCommand: String {
        switch self {
        case .mint:
            return "mint list"
        case .brew:
            return "brew list"
        }
    }
    
    /// The update command
    var updateCommand: String {
        switch self {
        case .mint:
            return "mint install SvenTiigi/SwiftKit"
        case .brew:
            return "brew upgrade swiftkit"
        }
    }
    
}
