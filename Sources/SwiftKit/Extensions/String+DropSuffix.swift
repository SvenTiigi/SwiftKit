//
//  String+DropSuffix.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

extension String {
    
    /// Drop suffix from String
    ///
    /// - Parameter suffix: The suffix that should be removed
    /// - Returns: The String without suffix
    func drop(suffix: String) -> String {
        // Verify Suffix is available
        guard self.hasSuffix(suffix) else {
            // Suffix is unavailable return self
            return self
        }
        // Initialize Start Index
        let startIndex = self.index(self.endIndex, offsetBy: -suffix.count)
        // Remove Suffix and return updated string
        return self.replacingCharacters(in: startIndex..<self.endIndex, with: "")
    }
    
}
