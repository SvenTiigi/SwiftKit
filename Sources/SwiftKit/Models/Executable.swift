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
    
    /// Print text
    ///
    /// - Parameter text: The text that should be printed out
    func print(_ text: String)
    
    /// Print an Error
    ///
    /// - Parameter error: The Error that should be printed out
    func print(error: Error)
    
    /// Read line
    ///
    /// - Parameter prompt: The optional prompt text
    /// - Returns: The retrieved line if available
    func readLine(prompt: String?) -> String?
    
    /// Terminate CLI
    func terminate()
    
}
