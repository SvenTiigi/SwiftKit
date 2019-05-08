//
//  DispatchQueueUpdateNotificationService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 08.05.19.
//

import Foundation

// MARK: - DispatchQueueUpdateNotificationService

/// The DispatchQueueUpdateNotificationService
class DispatchQueueUpdateNotificationService {
    
    // MARK: Properties
    
    /// The current Version
    let currentVersion: Version
    
    /// The UpdateCheckService
    let updateCheckService: UpdateCheckService
    
    /// The DispatchQueue
    let dispatchQueue: DispatchQueue
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - currentVersion: The current Version
    ///   - updateCheckService: The UpdateCheckService
    ///   - dispatchQueue: The DispatchQueue. Default value `.init`
    init(currentVersion: Version,
         updateCheckService: UpdateCheckService,
         dispatchQueue: DispatchQueue = .init(label: "update-notification-service")) {
        self.currentVersion = currentVersion
        self.updateCheckService = updateCheckService
        self.dispatchQueue = dispatchQueue
    }
    
}

// MARK: - UpdateNotificationService

extension DispatchQueueUpdateNotificationService: UpdateNotificationService {
    
    /// Retrieve an optional UpdateNotification via the completion closure
    ///
    /// - Parameter completion: The completion closure
    func getUpdateNotification(_ completion: @escaping (UpdateNotification?) -> Void) {
        // Async on DispatchQueue
        self.dispatchQueue.async { [weak self] in
            // Check for Update with completion closure
            self?.checkForUpdate(completion)
        }
    }
    
}

// MARK: - Check Version

extension DispatchQueueUpdateNotificationService {
    
    /// Check for an available Update
    ///
    /// - Parameter completion: The completion closure
    func checkForUpdate(_ completion: @escaping (UpdateNotification?) -> Void) {
        // Invoke the completion by flat mapping the optional UpdateResult to an UpdateNotification
        completion(self.updateCheckService.check(version: self.currentVersion).flatMap(UpdateNotification.init))
    }
    
}
