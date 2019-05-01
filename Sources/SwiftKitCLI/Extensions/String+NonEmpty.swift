//
//  String+NonEmpty.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

extension String {
    
    /// Retrieve non empty String representation if available
    var nonEmpty: String? {
        // Verify self is not empty after trimming whitespaces
        guard !self.trimmingCharacters(in: .whitespaces).isEmpty else {
            // Self is empty return nil
            return nil
        }
        // Return self
        return self
    }
    
}
