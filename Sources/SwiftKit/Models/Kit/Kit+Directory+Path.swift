//
//  Kit+Directory+Path.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 26.05.19.
//

import Foundation

// MARK: - Path

extension Kit.Directory {
    
    /// The Path
    struct Path: Codable, Equatable, Hashable {
        
        /// The raw value
        var rawValue: String
        
    }
    
}

// MARK: - Last Component

extension Kit.Directory.Path {
    
    /// The last path component
    var lastComponent: String? {
        // Check if raw value can be constructed to an URL
        if let url = URL(string: self.rawValue) {
            // Return last path component
            return url.lastPathComponent
        } else {
            // Otherwise return last component separated by slash
            return self.rawValue
                .drop(suffix: "/")
                .components(separatedBy: "/")
                .last
        }
    }
    
}

// MARK: - Append

extension Kit.Directory.Path {
    
    /// Appends a path component
    ///
    /// - Parameter pathComponent: The path component that should be appended
    mutating func append(_ pathComponent: String) {
        // Check if raw value can be constructed to an URL
        if var url = URL(string: self.rawValue) {
            // Append path component
            url.appendPathComponent(pathComponent)
            // Set raw value
            self.rawValue = url.absoluteString
        } else {
            // Initialize mutable copy of raw value
            var rawValue = self.rawValue
            // Drop last slash character
            while rawValue.last == "/" {
                rawValue = .init(rawValue.dropLast())
            }
            // Initialize mutable path component
            var pathComponent = pathComponent
            // Drop first slash character
            while pathComponent.first == "/" {
                pathComponent = .init(pathComponent.dropFirst())
            }
            // Concat raw value with path component
            self.rawValue = rawValue + "/" + pathComponent
        }
    }
    
    /// Returns a new Path by appending the path component
    ///
    /// - Parameter pathComponent: The path component that should be appended
    /// - Returns: The new Path
    func appending(_ pathComponent: String) -> Kit.Directory.Path {
        // Initialize mutable Path
        var path = self
        // Append path component
        path.append(pathComponent)
        // Return appended Path
        return path
    }
    
}
