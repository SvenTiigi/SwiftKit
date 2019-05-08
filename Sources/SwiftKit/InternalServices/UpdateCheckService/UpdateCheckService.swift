//
//  UpdateCheckService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - UpdateCheckService

/// The UpdateCheckService
protocol UpdateCheckService {
    
    /// Check for Updates
    ///
    /// - Parameter version: The current installed Version
    /// - Returns: An UpdateResult if available
    func check(version: Version) -> UpdateResult?
    
}
