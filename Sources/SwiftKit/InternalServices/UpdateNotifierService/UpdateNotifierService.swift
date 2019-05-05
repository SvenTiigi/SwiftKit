//
//  UpdateNotifierService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation

// MARK: - UpdateNotifierService

/// The UpdateNotifierService
protocol UpdateNotifierService {
    
    /// Notify about an available update if needed
    func notifyIfNeeded()
    
}
