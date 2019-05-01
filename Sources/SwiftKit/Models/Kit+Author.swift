//
//  Kit+Author.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - Author

public extension Kit {
    
    /// The Author
    struct Author: Codable, Equatable, Hashable {
        
        // MARK: Properties
        
        /// The name
        public let name: String
        
        /// The email address
        public let email: String
        
        // MARK: Initializer
        
        /// Desingated Initializer
        ///
        /// - Parameters:
        ///   - name: The name
        ///   - email: The email address
        public init(name: String,
                    email: String) {
            self.name = name
            self.email = email
        }
        
    }
    
}
