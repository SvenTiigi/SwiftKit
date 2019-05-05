//
//  Executable.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 04.05.19.
//

import Foundation

// MARK: - Executable

/// The Executable
public protocol Executable {
    
    /// Execute the command
    ///
    /// - Parameter command: The command that should be executed
    /// - Returns: The corresponding output
    /// - Throws: If execution fails
    @discardableResult
    func execute(_ command: String) throws -> String
    
}
