//
//  DefaultTemplatePlaceholderMigrationService.swift
//  Kit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - DefaultTemplatePlaceholderMigrationService

/// The DefaultTemplatePlaceholderMigrationService
struct DefaultTemplatePlaceholderMigrationService {
    
    // MARK: Properties
    
    /// The FileManager
    let fileManager: FileManager
    
    /// Designated Initializer
    ///
    /// - Parameter fileManager: The FileManager. Default value `.default`
    init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
    
}

// MARK: - TemplatePlaceholderMigrationService

extension DefaultTemplatePlaceholderMigrationService: TemplatePlaceholderMigrationService {
    
    /// Migrate TemplatePlaceholder
    ///
    /// - Parameters:
    ///   - atPath: The Path
    ///   - placeholder: The TemplatePlaceholder
    func migrate(atPath folderPath: String, placeholder: TemplatePlaceholder) {
        // Migrate Files at folder path with TemplatePlaceholder
        self.migrateFiles(atPath: folderPath, placeholder: placeholder)
        // Migrate CIServices at folder path with TemplatePlaceholder
        self.migrateCIServices(atPath: folderPath, placeholder: placeholder)
    }
    
}

// MARK: - Migrate Files

extension DefaultTemplatePlaceholderMigrationService {
    
    /// Migrate TemplatePlaceholder
    ///
    /// - Parameters:
    ///   - atPath: The Path
    ///   - placeholder: The TemplatePlaceholder
    func migrateFiles(atPath folderPath: String, placeholder: TemplatePlaceholder) {
        // Initialize current File Name
        let currentFileName = URL(fileURLWithPath: #file).lastPathComponent
        // Verify Item Names are available for contents of Directory at Folder Path
        guard let itemNames = try? self.fileManager.contentsOfDirectory(atPath: folderPath) else {
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
            let itemPath = folderPath + "/" + itemName
            // Initialize new Item Paht
            let newItemPath = folderPath + "/" + self.replace(string: itemName, with: placeholder)
            do {
                // Check if Item Path is a Folder
                if self.fileManager.isFolder(atPath: itemPath) {
                    // Migrate Files in Folder with Item Path
                    self.migrateFiles(atPath: itemPath, placeholder: placeholder)
                    // Rename Item
                    try self.fileManager.moveItem(
                        atPath: itemPath,
                        toPath: newItemPath
                    )
                } else {
                    // When Item Path is not a Folder retrieve contents of File
                    let fileContents = try String(contentsOfFile: itemPath)
                    // Process File Contents and store updated String
                    let updatedFileContents = self.replace(
                        string: fileContents,
                        with: placeholder
                    )
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

// MARK: - Migrate CIServices

extension DefaultTemplatePlaceholderMigrationService {
    
    /// Migrate CIServices which will remove all CIServices files except if the
    /// TemplatePlaceholder contains a selected CIService
    ///
    /// - Parameters:
    ///   - folderPath: The folder path
    ///   - placeholder: The TemplatePlaceholder
    func migrateCIServices(atPath folderPath: String, placeholder: TemplatePlaceholder) {
        // Iterate through all CIServices
        for ciService in TemplatePlaceholder.CIService.allCases {
            // Verify CIService is not equal to the CIService defined in the TemplatePlaceholder
            guard ciService != placeholder.ciService else {
                // Continue with next CIService
                continue
            }
            // Remove not choosen CIService file
            try? self.fileManager.removeItem(
                atPath: folderPath + "/" + ciService.fileName
            )
        }
    }
    
}

// MARK: - Replace

extension DefaultTemplatePlaceholderMigrationService {
    
    /// Replace String with TemplatePlaceholder
    ///
    /// - Parameters:
    ///   - string: The String
    ///   - placeholder: The TemplatePlaceholder
    /// - Returns: The updated String
    func replace(string: String, with placeholder: TemplatePlaceholder) -> String {
        // Initialize mutable replaced String
        var replacedString = string
        // For each Key-Value-Pair
        for keyValuePair in placeholder.keyValuePairs {
            // Re-Initialize replaced String
            replacedString = replacedString.replacingOccurrences(
                of: keyValuePair.key,
                with: keyValuePair.value
            )
        }
        // Return replaced String
        return replacedString
    }
    
}

// MARK: - FileManager+isFolder

private extension FileManager {
    
    /// Retrieve Bool if Path if Folder
    ///
    /// - Parameter path: The Path
    /// - Returns: Return true if the given Path is a Folder
    func isFolder(atPath path: String) -> Bool {
        var objCBool: ObjCBool = false
        guard fileExists(atPath: path, isDirectory: &objCBool) else {
            return false
        }
        return objCBool.boolValue
    }
    
}
