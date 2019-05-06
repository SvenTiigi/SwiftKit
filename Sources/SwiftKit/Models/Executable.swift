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
    
    /// Print error
    ///
    /// - Parameter text: The text that should be printed out
    func printError(_ text: String)
    
    /// Start loading
    ///
    /// - Parameter message: The optional message
    func startLoading(message: String?)
    
    /// Stop loading
    ///
    /// - Parameter message: The optional message
    func stopLoading(message: String?)
    
    /// Read line
    ///
    /// - Parameter prompt: The optional prompt text
    /// - Returns: The retrieved line if available
    func readLine(prompt: String?) -> String?
    
    /// Terminate Executable
    func terminate()
    
}

// MARK: - Convenience Functions

extension Executable {
    
    /// Start loading
    func startLoading() {
        self.startLoading(message: nil)
    }
    
    /// Stop loading
    func stopLoading() {
        self.stopLoading(message: nil)
    }
    
}
