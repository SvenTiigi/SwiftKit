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
        var path: String
        
    }
    
}

// MARK: - Defaults

extension Kit.Directory {
    
    /// Retrieve default Kit.Directory
    ///
    /// - Parameter fileManager: The FileManager. Default value `.default`
    /// - Returns: The Kit Directory
    static func `default`(fileManager: FileManager = .default) -> Kit.Directory {
        return .init(path: fileManager.currentDirectoryPath)
    }
    
}
