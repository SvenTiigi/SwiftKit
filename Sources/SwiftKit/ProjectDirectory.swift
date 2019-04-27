//
//  ProjectDirectory.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - ProjectDirectory

/// The ProjectDirectory
struct ProjectDirectory: Codable, Equatable, Hashable {
    
    /// The Path
    var path: String
    
}

// MARK: - Initializer

extension ProjectDirectory {
    
    /// Designated Initializer
    ///
    /// - Parameter fileManager: The FileManager. Default value `.default`
    init(fileManager: FileManager = .default) {
        self.path = fileManager.currentDirectoryPath
    }
    
}
