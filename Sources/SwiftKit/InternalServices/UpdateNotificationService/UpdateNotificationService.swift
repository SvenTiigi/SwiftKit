//
//  UpdateNotificationService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 08.05.19.
//

import Foundation

// MARK: - UpdateNotificationService

/// The UpdateNotificationService
protocol UpdateNotificationService {
    
    /// Retrieve an optional UpdateNotification via the completion closure
    ///
    /// - Parameter completion: The completion closure
    func getUpdateNotification(_ completion: @escaping (UpdateNotification?) -> Void)
    
}
