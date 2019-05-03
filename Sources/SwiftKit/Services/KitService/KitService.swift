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
    
    /// Generate Kit at Directory
    ///
    /// - Parameters:
    ///   - kit: The Kit
    ///   - directory: The Kit Directory
    /// - Throws: If generating fails
    func generate(kit: Kit, at directory: Kit.Directory) throws
    
}
