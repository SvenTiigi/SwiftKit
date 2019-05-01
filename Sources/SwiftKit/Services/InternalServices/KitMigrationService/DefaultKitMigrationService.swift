//
//  DefaultKitMigrationService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - DefaultKitMigrationService

/// The DefaultKitMigrationService
struct DefaultKitMigrationService {
    
    // MARK: Properties
    
    /// The FileManager
    let fileManager: FileManager
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameter fileManager: The FileManager. Default value `.default`
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
}

// MARK: - KitMigrationService

extension DefaultKitMigrationService: KitMigrationService {
    
    /// Migrate Kit at Directory
    ///
    /// - Parameters:
    ///   - kit: The Kit
    ///   - kitDirectory: The Kit Directory
    /// - Throws: If migration fails
    func migrate(kit: Kit, at kitDirectory: Kit.Directory) throws {
        // Migrate Files in Kit Directory
        self.migrateFiles(
            in: kitDirectory,
            for: kit
        )
        // Migrate CIService in Kit Directory
        self.migrateCIService(
            in: kitDirectory,
            for: kit
        )
    }
    
}

// MARK: - Migrate Files

extension DefaultKitMigrationService {
    
    /// Migrate Files in Kit Directory for Kit
    ///
    /// - Parameters:
    ///   - kitDirectory: The Kit directory
    ///   - kit: The Kit
    func migrateFiles(in kitDirectory: Kit.Directory, for kit: Kit) {
        // Initialize current File Name
        let currentFileName = URL(fileURLWithPath: #file).lastPathComponent
        // Verify Item Names are available for contents of Kit Directory
        guard let itemNames = try? self.fileManager.contentsOfDirectory(atPath: kitDirectory.path) else {
            // Item Names are unavailable return
            return
        }
        // For each ItemName
        for itemName in itemNames {
            // Verify Item name is not equal to current file name
            guard itemName != currentFileName else {
                // Other wise continue with next ItemName
                continue
            }
            // Initialize Item Path
            let itemPath = kitDirectory.path + "/" + itemName
            // Initialize new Item Path
            let newItemPath = kitDirectory.path + "/" + itemName.replacing(placeholders: kit.placeholders)
            do {
                // Check if Item Path is a Folder
                if self.fileManager.isFolder(atPath: itemPath) {
                    // Migrate Files in Folder with Item Path
                    self.migrateFiles(in: .init(path: itemPath), for: kit)
                    // Rename Item
                    try self.fileManager.moveItem(
                        atPath: itemPath,
                        toPath: newItemPath
                    )
                } else {
                    // When Item Path is not a Folder retrieve contents of File
                    let fileContents = try String(contentsOfFile: itemPath)
                    // Process File Contents and store updated String
                    let updatedFileContents = fileContents.replacing(placeholders: kit.placeholders)
                    // Try to write updated File Contents back to the FileSystem
                    try updatedFileContents.write(
                        toFile: newItemPath,
                        atomically: false,
                        encoding: .utf8
                    )
                    // Check if new Item Path is not equal to the Item Path
                    if newItemPath != itemPath {
                        // Remove Item Path
                        try self.fileManager.removeItem(atPath: itemPath)
                    }
                }
            } catch {
                // Error occured continue with next element
                continue
            }
        }
    }
    
}

// MARK: - Migrate CIService

extension DefaultKitMigrationService {
    
    /// Migrate CIService which will remove all CIServices files except if the
    /// TemplatePlaceholder contains a selected CIService
    ///
    /// - Parameters:
    ///   - kitDirectory: The Kit directory
    ///   - kit: The Kit
    func migrateCIService(in kitDirectory: Kit.Directory, for kit: Kit) {
        // Iterate through all CIServices
        for ciService in CIService.allCases {
            // Verify CIService is not equal to the CIService defined in the Kit
            guard ciService != kit.ciService else {
                // Continue with next CIService
                continue
            }
            // Remove not choosen CIService file and discard any error
            try? self.fileManager.removeItem(
                atPath: kitDirectory.path + "/" + ciService.fileName
            )
        }
    }
    
}

// MARK: - String+Replacing with Placeholders

private extension String {
    
    /// Replace all occurrences of Placeholder keys in string with its corresponding value
    ///
    /// - Parameter placeholders: The Placeholder Dictionary
    /// - Returns: The replaced String
    func replacing(placeholders: [String: String]) -> String {
        // Initialize mutable String
        var string = self
        // For each Placeholder
        for placeholder in placeholders {
            // Re-Initialize replaced String
            string = string.replacingOccurrences(
                of: placeholder.key,
                with: placeholder.value
            )
        }
        // Return replaced String
        return string
    }
    
}

// MARK: - FileManager+isFolder

private extension FileManager {
    
    /// Retrieve Bool if Path if Folder
    ///
    /// - Parameter path: The Path
    /// - Returns: Return true if the given Path is a Folder
    func isFolder(atPath path: String) -> Bool {
        // Initialize Objc Bool
        var objCBool: ObjCBool = false
        // Verify file exists at Path
        guard self.fileExists(atPath: path, isDirectory: &objCBool) else {
            // File does not exists return false
            return false
        }
        // Return objc bool value
        return objCBool.boolValue
    }
    
}
