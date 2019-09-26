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
    func migrate(kit: Kit, at kitDirectory: Kit.Directory) {
        // Iterate through all CIServices
        for ciService in Kit.CIService.allCases {
            // Verify CIService is not equal to the CIService defined in the Kit
            guard ciService != kit.ciService else {
                // Continue with next CIService
                continue
            }
            // Check if a source directory is available
            if let sourceDirectory = ciService.sourceDirectory {
                // Initialize source directory path
                let sourceDirectoryPath = kitDirectory.path.appending(sourceDirectory)
                // Remove not choosen CIService file and discard any error
                try? self.fileManager.removeItem(
                    atPath: sourceDirectoryPath.appending(ciService.sourceFileName).rawValue
                )
                // Remove source directory and discard any error
                try? self.fileManager.removeItem(
                    atPath: sourceDirectoryPath.rawValue
                )
            } else {
                // Remove not choosen CIService file and discard any error
                try? self.fileManager.removeItem(
                    atPath: kitDirectory.path.appending(ciService.sourceFileName).rawValue
                )
            }
        }
        // Initialize map CIServices to XcodeFileReferences and filter out selected one
        let fileReferences = Kit.CIService.allCases
            .map { $0.fileReference }
            .filter { $0.name != kit.ciService?.fileReference.name }
        // Remove not choosen CIServices FileReferences in XcodeProject
        try? self.xcodeProjectService.remove(
            fileReferences: fileReferences,
            in: kitDirectory
        )
        // Check if the CI Service is available and has a Target FileName
        if let ciService = kit.ciService, let targetFileName = ciService.targetFileName {
            // Initialize source path
            let sourcePath = kitDirectory.path.appending(ciService.sourceFileName).rawValue
            // Initialize destination path
            let destinationPath = kitDirectory.path.appending(targetFileName).rawValue
            // Rename CI Service file name
            try? self.fileManager.moveItem(atPath: sourcePath, toPath: destinationPath)
        }
    }
    
}

// MARK: - CIService+FileReference

private extension Kit.CIService {
    
    /// The XcodeFileReference
    var fileReference: XcodeFileReference {
        // Initialize name with targetFileName if available or sourceFileName
        var name = self.targetFileName ?? self.sourceFileName
        // Check if a source directory is available
        if let sourceDirectory = self.sourceDirectory {
            // Initialize source directory Path
            let sourceDirectoryPath = Kit.Directory.Path(
                rawValue: sourceDirectory
            )
            // Re-Initialize name by appedending the name to the source directory
            // path and retrieve its raw value
            name = sourceDirectoryPath.appending(name).rawValue
        }
        // Return XcodeFileReference
        return .init(name: name)
    }
    
}
