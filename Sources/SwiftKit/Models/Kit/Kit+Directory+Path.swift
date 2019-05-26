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
        if let url = URL(string: self.rawValue) {
            return url.lastPathComponent
        } else {
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
        if var url = URL(string: self.rawValue) {
            url.appendPathComponent(pathComponent)
            self.rawValue = url.absoluteString
        } else {
            var rawValue = self.rawValue
            while rawValue.last == "/" {
                rawValue = .init(rawValue.dropLast())
            }
            var pathComponent = pathComponent
            while pathComponent.first == "/" {
                pathComponent = .init(pathComponent.dropFirst())
            }
            self.rawValue = rawValue + "/" + pathComponent
        }
    }
    
    /// Returns a new Path by appending the path component
    ///
    /// - Parameter pathComponent: The path component that should be appended
    /// - Returns: The new Path
    func appending(_ pathComponent: String) -> Kit.Directory.Path {
        var path = self
        path.append(pathComponent)
        return path
    }
    
}
