//
//  GitConfigService.swift
//  Kit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - GitConfigService

/// The GitConfigService
protocol GitConfigService {
    
    /// Retrieve config value for key
    ///
    /// - Parameter key: The config key
    /// - Returns: The corresponding value if available
    func getValue(forKey key: String) -> String?
    
}
