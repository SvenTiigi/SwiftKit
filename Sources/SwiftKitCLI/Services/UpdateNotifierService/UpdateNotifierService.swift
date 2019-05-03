//
//  UpdateNotifierService.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 03.05.19.
//

import Foundation
import SwiftCLI

// MARK: - UpdateNotifierService

/// The UpdateNotifierService
protocol UpdateNotifierService {
    
    /// Notify about an available update
    ///
    /// - Parameter command: The Command
    func notifyIfNeeded(on command: Command)
    
}
