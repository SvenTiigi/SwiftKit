//
//  String+NonEmpty.swift
//  SwiftCLI
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

extension String {
    
    /// Retrieve non empty String representation if available
    var nonEmpty: String? {
        guard !self.trimmingCharacters(in: .whitespaces).isEmpty else {
            return nil
        }
        return self
    }
    
}
