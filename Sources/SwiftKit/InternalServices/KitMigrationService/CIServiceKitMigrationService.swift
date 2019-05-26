//
//  CIServiceKitMigrationService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 26.05.19.
//

import Foundation

// MARK: - CIServiceKitMigrationService

/// The CIServiceKitMigrationService
struct CIServiceKitMigrationService {
    
    // MARK: Properties
    
    /// The FileManager
    let fileManager: FileManager
    
    /// The XcodeProjectService
    let xcodeProjectService: XcodeProjectService
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - fileManager: The FileManager. Default value `.default`
    ///   - xcodeProjectService: The XcodeProjectService
    init(fileManager: FileManager = .default,
         xcodeProjectService: XcodeProjectService) {
        self.fileManager = fileManager
        self.xcodeProjectService = xcodeProjectService
    }
    
}

// MARK: - KitMigrationService

extension CIServiceKitMigrationService: KitMigrationService {
    
    /// Migrate Kit at Directory
    ///
    /// - Parameters:
    ///   - kit: The Kit
    ///   - kitDirectory: The Kit Directory
    /// - Throws: If migration fails
    func migrate(kit: Kit, at kitDirectory: Kit.Directory) throws {
        // Iterate through all CIServices
        for ciService in Kit.CIService.allCases {
            // Verify CIService is not equal to the CIService defined in the Kit
            guard ciService != kit.ciService else {
                // Continue with next CIService
                continue
            }
            // Remove not choosen CIService file and discard any error
            try? self.fileManager.removeItem(
                atPath: kitDirectory.path.appending(ciService.sourceFileName).rawValue
            )
        }
        // Check if an CI Service is available
        if let ciService = kit.ciService {
            // Initialize source path
            let sourcePath = kitDirectory.path.appending(ciService.sourceFileName).rawValue
            // Initialize destination path
            let destinationPath = kitDirectory.path.appending(ciService.targetFileName).rawValue
            // Rename CI Service file name
            try? self.fileManager.moveItem(atPath: sourcePath, toPath: destinationPath)
        }
    }
    
}
