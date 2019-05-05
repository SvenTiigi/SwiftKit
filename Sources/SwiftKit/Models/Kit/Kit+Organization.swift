//
//  Kit+Organization.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - Organization

extension Kit {
    
    /// The Organization
    struct Organization: Codable, Equatable, Hashable {
        
        /// The name
        let name: String
        
        /// The identifier
        let identifier: String
        
    }
    
}
