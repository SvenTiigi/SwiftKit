//
//  CocoaPodsService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 03.05.19.
//

import Foundation

// MARK: - CocoaPodsService

/// The CocoaPodsService
public protocol CocoaPodsService {
    
    /// Check if a Pod with a given name is available
    ///
    /// - Parameter name: The Pod name
    /// - Returns: Bool if Pod is available / already taken
    func isPodAvailable(forName name: String) -> Bool
    
}
