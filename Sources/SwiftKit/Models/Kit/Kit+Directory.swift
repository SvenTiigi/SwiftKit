//
//  Kit+Directory.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - Directory

extension Kit {
    
    /// The Directory
    struct Directory: Codable, Equatable, Hashable {

        /// The Path
        var path: Path
        
    }
    
}

// MARK: - Initializer

extension Kit.Directory {
    
    /// Initialize with path string
    ///
    /// - Parameter path: The path string
    init(path: String) {
        self.path = .init(rawValue: path)
    }
    
}

// MARK: - Defaults

extension Kit.Directory {
    
    /// Retrieve default Kit.Directory
    ///
    /// - Parameter fileManager: The FileManager. Default value `.default`
    /// - Returns: The Kit Directory
    static func `default`(fileManager: FileManager = .default) -> Kit.Directory {
        return .init(path: .init(rawValue: fileManager.currentDirectoryPath))
    }
    
}
