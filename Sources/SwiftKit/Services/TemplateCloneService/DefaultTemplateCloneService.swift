//
//  DefaultTemplateCloneService.swift
//  Kit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation
import SwiftCLI

// MARK: - DefaultTemplateCloneService

/// The DefaultTemplateCloneService
struct DefaultTemplateCloneService {
    
    /// The Clone URL
    let cloneURL: String

    /// The FileManager
    let fileManager: FileManager
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - cloneURL: The Clone URL. Default value `https://github.com/SvenTiigi/SwiftKit.git`
    ///   - fileManager: The FileManager
    init(cloneURL: String = "https://github.com/SvenTiigi/SwiftKit.git",
         fileManager: FileManager = .default) {
        self.cloneURL = cloneURL
        self.fileManager = fileManager
    }
    
}

// MARK: - TemplateCloneService

extension DefaultTemplateCloneService: TemplateCloneService {
    
    /// Clone Template
    ///
    /// - Parameter folderPath: The path to clone into
    /// - Throws: If cloning fails
    func clone(atPath folderPath: String) throws {
        // Remove any previous temporary folder
        try? self.fileManager.removeItem(atPath: self.tempFolderPath(basePath: folderPath))
        // Make a new temporary folder
        try fileManager.createDirectory(
            atPath: self.tempFolderPath(basePath: folderPath),
            withIntermediateDirectories: true,
            attributes: nil
        )
        // Make a local clone of the new Kit Repo
        try run(bash: "git clone \(self.cloneURL) '\(self.clonePath(basePath: folderPath))' -q")
        // Copy Template Folder
        for itemName in try fileManager.contentsOfDirectory(atPath: self.clonedTemplatePath(basePath: folderPath)) {
            let originPath = self.clonedTemplatePath(basePath: folderPath) + "/" + itemName
            let destinationPath = folderPath + "/" + itemName
            try fileManager.copyItem(atPath: originPath, toPath: destinationPath)
        }
        // Remove temporary folder
        try fileManager.removeItem(atPath: self.tempFolderPath(basePath: folderPath))
    }
    
}

// MARK: - URLs

extension DefaultTemplateCloneService {
    
    /// The Temp Folder Path
    func tempFolderPath(basePath: String) -> String {
        return basePath + "/swiftkit_temp"
    }
    
    /// The ClonePath
    func clonePath(basePath: String) -> String {
        return self.tempFolderPath(basePath: basePath) + "/SwiftKit"
    }
    
    /// The cloned Kit Template Path
    func clonedTemplatePath(basePath: String) -> String {
        return self.clonePath(basePath: basePath) + "/Template"
    }
    
}
