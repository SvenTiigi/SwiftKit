//
//  CocoaPodsService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 03.05.19.
//

import Foundation

// MARK: - CocoaPodsService

/// The CocoaPodsService
protocol CocoaPodsService {
    
    /// Check if a Pod with a given name is available
    ///
    /// - Parameters:
    ///   - name: The Pod name
    ///   - completion: The completion closure
    func isPodAvailable(forName name: String, _ completion: @escaping (Bool) -> Void)
    
}
