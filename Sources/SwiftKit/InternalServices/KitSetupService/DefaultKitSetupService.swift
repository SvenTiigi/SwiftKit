//
//  DefaultKitSetupService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - DefaultKitSetupService

/// The DefaultKitSetupService
struct DefaultKitSetupService {
    
    /// The Git URL
    let gitURL: String
    
    /// The GitBranch
    let gitBranch: GitBranch
    
    /// The FileManager
    let fileManager: FileManager
    
    /// The GitService
    let gitService: GitService
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - gitURL: The Git URL
    ///   - gitBranch: The GitBranch. Default value `.master`
    ///   - fileManager: The FileManager. Default value `.default`
    ///   - gitService: The GitService
    init(gitURL: String,
         gitBranch: GitBranch = .master,
         fileManager: FileManager = .default,
         gitService: GitService) {
        self.gitURL = gitURL
        self.gitBranch = gitBranch
        self.fileManager = fileManager
        self.gitService = gitService
    }
    
}

// MARK: - KitSetupService

extension DefaultKitSetupService: KitSetupService {
    
    /// Setup Kit at Directory
    ///
    /// - Parameter kitDirectory: The Kit Directory
    /// - Throws: If setup fails
    func setup(at kitDirectory: Kit.Directory) throws {
        // Defer execution
        defer {
            // Remove temporary folder and ignore error
            try? self.fileManager.removeItem(
                atPath: kitDirectory.path.appendedTempFolderPath.rawValue
            )
        }
        // Remove any previous temporary folder and ignore error
        try? self.fileManager.removeItem(
            atPath: kitDirectory.path.appendedTempFolderPath.rawValue
        )
        do {
            // Make a new temporary folder
            try self.fileManager.createDirectory(
                atPath: kitDirectory.path.appendedTempFolderPath.rawValue,
                withIntermediateDirectories: true,
                attributes: nil
            )
        } catch {
            // Throw SwiftKitError
            throw SwiftKitError.createKitDirectoryFailed(kitDirectory, error)
        }
        do {
            // Try to clone from Git URL
            try self.gitService.clone(
                from: self.gitURL,
                to: kitDirectory.path.appendedClonePath.rawValue,
                branch: self.gitBranch
            )
        } catch {
            // Throw SwiftKitError
            throw SwiftKitError.cloneFailed(gitURL: self.gitURL, self.gitBranch, error)
        }
        // Declare Files
        let files: [String]
        do {
            // Retrieve all Files in cloned template path
            files = try self.fileManager.contentsOfDirectory(
                atPath: kitDirectory.path.appendedClonedTemplatePath.rawValue
            )
        } catch {
            // Throw SwiftKitError
            throw SwiftKitError.directoryContentUnavailable(
                kitDirectory.path.appendedClonedTemplatePath.rawValue,
                error
            )
        }
        // For each file
        for file in files {
            // Initialize Origin
            let origin = kitDirectory.path.appendedClonedTemplatePath.appending(file).rawValue
            // Initialize Destination
            let destination = kitDirectory.path.appending(file).rawValue
            do {
                // Copy Item from origin to destination
                try self.fileManager.copyItem(
                    atPath: origin,
                    toPath: destination
                )
            } catch {
                // Throw SwiftKitError
                throw SwiftKitError.copyItemFailed(
                    origin: origin,
                    destination: destination,
                    error
                )
            }
        }
    }
    
}

// MARK: - Path+appended

private extension Kit.Directory.Path {
    
    /// The appended TempFolder Path
    var appendedTempFolderPath: Kit.Directory.Path {
        return self.appending("swiftkit_temp")
    }
    
    /// The appended Clone Path
    var appendedClonePath: Kit.Directory.Path {
        return self.appendedTempFolderPath.appending("SwiftKit")
    }
    
    /// The appended ClondedTemplate Path
    var appendedClonedTemplatePath: Kit.Directory.Path {
        return self.appendedClonePath.appending("Template")
    }
    
}

// MARK: - SwiftKitError+Defaults

private extension SwiftKitError {
    
    /// Create Directory failed SwiftKitError
    ///
    /// - Parameters:
    ///   - kitDirectory: The Kit Directory
    ///   - error: The Error
    /// - Returns: A SwiftKitError
    static func createKitDirectoryFailed(_ kitDirectory: Kit.Directory, _ error: Error) -> SwiftKitError {
        return .init(
            reason: "Unable to create Kit Directory at path: \(kitDirectory.path)",
            error: error
        )
    }
    
    /// Clone failed SwiftKitError
    ///
    /// - Parameters:
    ///   - gitURL: The Git URL
    ///   - gitBranch: The Git Branch
    ///   - error: The Error
    /// - Returns: A SwiftKitError
    static func cloneFailed(gitURL: String, _ gitBranch: GitBranch, _ error: Error) -> SwiftKitError {
        return .init(
            reason: "Unable to clone Kit template from url: \(gitURL) (Branch: \(gitBranch.name))",
            error: error
        )
    }
    
    /// Directory content unavailable SwiftKitError
    ///
    /// - Parameters:
    ///   - path: The Path
    ///   - error: The Error
    /// - Returns: A SwiftKitError
    static func directoryContentUnavailable(_ path: String, _ error: Error) -> SwiftKitError {
        return .init(
            reason: "Unable to retrieve contents of directory at path: \(path)",
            error: error
        )
    }
    
    /// Copy item failed SwiftKitError
    ///
    /// - Parameters:
    ///   - origin: The origin path
    ///   - destination: The destination path
    ///   - error: The Error
    /// - Returns: A SwiftKitError
    static func copyItemFailed(origin: String, destination: String, _ error: Error) -> SwiftKitError {
        return .init(
            reason: "Unable to copy Kit template file from \(origin) to \(destination)",
            error: error
        )
    }
    
}
