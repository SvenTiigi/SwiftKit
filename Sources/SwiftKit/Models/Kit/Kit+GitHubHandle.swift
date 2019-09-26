//
//  Kit+GitHubHandle.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 04.08.19.
//

import Foundation

// MARK: - GitHubHandle

extension Kit {
    
    /// The GitHubHandle
    struct GitHubHandle: Codable, Equatable, Hashable {
        
        /// The raw value
        let rawValue: String
        
    }
    
}

// MARK: - Initializer

extension Kit.GitHubHandle {
    
    /// Initializer with Author and repository URL
    ///
    /// - Parameters:
    ///   - author: The Author
    ///   - repositoryURL: The repository URL
    init(author: Kit.Author, repositoryURL: String) {
        // Check if repository URL can be initialize to a URL and the first
        // path component which isn't a slash can be retrieved.
        if let url = URL(string: repositoryURL),
            let handle = url.pathComponents.filter({ $0 != "/" }).first {
            self.rawValue = handle
        } else {
            // Otherwise use the Author name without whitespaces
            self.rawValue = author.name.dropWhitespaces()
        }
    }
    
}
