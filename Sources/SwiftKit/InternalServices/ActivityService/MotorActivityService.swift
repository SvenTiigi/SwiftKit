//
//  MotorActivityService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation
import Motor

// MARK: - MotorActivityService

/// The MotorActivityService
struct MotorActivityService {
    
    // MARK: Properties
    
    /// The Motor Spinner
    let spinner: Motor.Spinner
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameter spinner: The Motor Spinner. Default value `init`
    init(spinner: Motor.Spinner = .init(pattern: Motor.Patterns.dots)) {
        self.spinner = spinner
    }
    
}

// MARK: - ActivityService

extension MotorActivityService: ActivityService {
    
    /// Start activity
    ///
    /// - Parameter message: The optional message text
    func start(message: String?) {
        if let message = message {
            self.spinner.start(message: message)
        } else {
            self.spinner.start()
        }
    }
    
    /// Stop activity
    ///
    /// - Parameter message: The optional message text
    func stop(message: String?) {
        self.spinner.stop(message: message)
    }
    
}
