//
//  String+DropWhitespaces.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 08.05.19.
//

import Foundation

extension String {
    
    /// Drop Whitespaces
    ///
    /// - Returns: The updated String with no whitespaces
    func dropWhitespaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
}
