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
    public struct Directory: Codable, Equatable, Hashable {
        
        // MARK: Properties
        
        /// The Path
        public var path: String
        
        // MARK: Initializer
        
        /// Designated Initializer
        ///
        /// - Parameter path: The Path
        public init(path: String) {
            self.path = path
        }
        
    }
    
}

// MARK: - Defaults

public extension Kit.Directory {
    
    /// Retrieve default Kit.Directory
    ///
    /// - Parameter fileManager: The FileManager. Default value `.default`
    /// - Returns: The Kit Directory
    static func `default`(fileManager: FileManager = .default) -> Kit.Directory {
        return .init(path: fileManager.currentDirectoryPath)
    }
    
}
