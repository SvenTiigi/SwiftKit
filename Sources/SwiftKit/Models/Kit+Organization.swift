//
//  Kit+Organization.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - Organization

public extension Kit {
    
    /// The Organization
    struct Organization: Codable, Equatable, Hashable {
        
        // MARK: Properties
        
        /// The name
        public let name: String
        
        /// The identifier
        public let identifier: String
        
        // MARK: Initializer
        
        /// Designated Initializer
        ///
        /// - Parameters:
        ///   - name: The name
        ///   - identifier: The identifier
        public init(name: String,
                    identifier: String) {
            self.name = name
            self.identifier = identifier
        }
        
    }
    
}
