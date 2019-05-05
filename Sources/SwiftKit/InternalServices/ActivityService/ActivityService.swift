//
//  ActivityService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation

// MARK: - ActivityService

/// The ActivityService
protocol ActivityService {
    
    /// Start activity
    ///
    /// - Parameter message: The optional message text
    func start(message: String?)
    
    /// Stop activity
    ///
    /// - Parameter message: The optional message text
    func stop(message: String?)
    
}

// MARK: - Convenience functions

extension ActivityService {
    
    /// Start activity
    func start() {
        self.start(message: nil)
    }
    
    /// Stop activity
    func stop() {
        self.stop(message: nil)
    }
    
}
