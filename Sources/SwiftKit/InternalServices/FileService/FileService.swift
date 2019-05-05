//
//  FileService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation

// MARK: - FileService

/// The FileService
protocol FileService {
    
    /// Open File at Path
    ///
    /// - Parameter path: The Path
    /// - Returns: If opening succeeded
    @discardableResult
    func open(atPath path: String) -> Bool
    
}
