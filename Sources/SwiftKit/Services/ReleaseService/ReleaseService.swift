//
//  ReleaseService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 07.08.19.
//

import Foundation

// MARK: - ReleaseService

/// The ReleaseService
public protocol ReleaseService {
    
    /// Release a new Version of a Kit
    ///
    /// - Parameters:
    ///   - directory: The optional Directory
    ///   - version: The optional Version
    func release(in directory: String?, version: String?)
    
}
