//
//  DateFormatter+Init.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - DateFormatter+Init

extension DateFormatter {
    
    /// Initialize with DateFormat
    ///
    /// - Parameter dateFormat: The DateFormat
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
    
}
