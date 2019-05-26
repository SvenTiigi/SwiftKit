//
//  Kit+Author.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - Author

extension Kit {
    
    /// The Author
    struct Author: Codable, Equatable, Hashable {
        
        /// The name
        let name: String
        
        /// The email address
        let email: String
        
    }
    
}
