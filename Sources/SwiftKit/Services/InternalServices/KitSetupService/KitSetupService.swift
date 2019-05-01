//
//  KitSetupService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - KitSetupService

/// The KitSetupService
protocol KitSetupService {
    
    /// Setup Kit at Directory
    ///
    /// - Parameter kitDirectory: The Kit Directory
    /// - Throws: If setup fails
    func setup(at kitDirectory: Kit.Directory) throws
    
}
