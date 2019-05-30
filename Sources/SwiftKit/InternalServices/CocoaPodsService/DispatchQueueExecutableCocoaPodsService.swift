//
//  DispatchQueueExecutableCocoaPodsService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 03.05.19.
//

import Dispatch
import Foundation

// MARK: - DispatchQueueExecutableCocoaPodsService

/// The DispatchQueueExecutableCocoaPodsService
class DispatchQueueExecutableCocoaPodsService {
    
    // MARK: Properties
    
    /// The Executable
    let executable: Executable
    
    /// The DispatchQueue
    let dispatchQueue: DispatchQueue
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - executable: The Executable
    ///   - dispatchQueue: The DispatchQueue. Default value `.init`
    init(executable: Executable,
         dispatchQueue: DispatchQueue = .init(label: "de.tiigi.SwiftKit.cocoapods-service")) {
        self.executable = executable
        self.dispatchQueue = dispatchQueue
    }
    
}

// MARK: - CocoaPodsService

extension DispatchQueueExecutableCocoaPodsService: CocoaPodsService {
    
    /// Check if a Pod with a given name is available
    ///
    /// - Parameters:
    ///   - name: The Pod name
    ///   - completion: The completion closure
    func isPodAvailable(forName name: String, _ completion: @escaping (Bool) -> Void) {
        // Async on DispatchQueue
        self.dispatchQueue.async { [weak self] in
            // Initialize pod trunk info for pod name
            let podTrunkInfo = try? self?.executable.execute("pod trunk info \(name)")
            // Initialize pod availability
            let podAvailability = podTrunkInfo != nil
            // Invoke completion with pod availability
            completion(podAvailability)
        }
    }
    
}
