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
    ///   - gitURL: The Git URL. Default value `https://github.com/SvenTiigi/SwiftKit.git`
    ///   - gitBranch: The GitBranch. Default value `.master`
    ///   - fileManager: The FileManager. Default value `.default`
    ///   - gitService: The GitService
    init(gitURL: String = "https://github.com/SvenTiigi/SwiftKit.git",
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
        // Remove any previous temporary folder
        try? self.fileManager.removeItem(
            atPath: self.tempFolderPath(kitDirectory.path)
        )
        // Make a new temporary folder
        try self.fileManager.createDirectory(
            atPath: self.tempFolderPath(kitDirectory.path),
            withIntermediateDirectories: true,
            attributes: nil
        )
        // Try to clone from Git URL
        try self.gitService.clone(
            from: self.gitURL,
            to: self.clonePath(kitDirectory.path),
            branch: self.gitBranch
        )
        // Retrieve all Files in cloned template path
        let files = try self.fileManager.contentsOfDirectory(
            atPath: self.clonedTemplatePath(kitDirectory.path)
        )
        // For each file
        for file in files {
            // Initialize Origin Path
            let originPath = self.clonedTemplatePath(kitDirectory.path) + "/" + file
            // Initialize Destination Path
            let destinationPath = kitDirectory.path + "/" + file
            // Copy Item from origin to destination
            try self.fileManager.copyItem(
                atPath: originPath,
                toPath: destinationPath
            )
        }
        // Remove temporary folder
        try self.fileManager.removeItem(
            atPath: self.tempFolderPath(kitDirectory.path)
        )
    }
    
}

// MARK: - URLs

extension DefaultKitSetupService {
    
    /// The Temp Folder Path
    func tempFolderPath(_ basePath: String) -> String {
        return basePath + "/swiftkit_temp"
    }
    
    /// The ClonePath
    func clonePath(_ basePath: String) -> String {
        return self.tempFolderPath(basePath) + "/SwiftKit"
    }
    
    /// The cloned Kit Template Path
    func clonedTemplatePath(_ basePath: String) -> String {
        return self.clonePath(basePath) + "/Template"
    }
    
}
