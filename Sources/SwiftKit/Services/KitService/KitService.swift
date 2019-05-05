//
//  KitService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - KitService

/// The KitService
public protocol KitService {
    
    /// Create Kit
    ///
    /// - Parameter arguments: The KitCreationArguments
    func create(with arguments: KitCreationArguments)
    
}
