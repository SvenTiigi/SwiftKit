//
//  SwiftKitCLI.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation
import Motor
import SwiftCLI
import SwiftKit

// MARK: - SwiftKitCLI

/// The SwiftKitCLI
final class SwiftKitCLI {
    
    /// The SwiftKit
    private lazy var swiftKit = SwiftKit(
        executable: self
    )
    
    /// The CLI Spinner
    private lazy var cliSpinner = Motor.Spinner(
        pattern: Motor.Patterns.dots
    )
    
    /// The CLI
    private lazy var cli = SwiftCLI.CLI(
        name: "swiftkit",
        version: self.swiftKit.version.description,
        commands: self.commands
    )
    
}

// MARK: - Start

extension SwiftKitCLI {
    
    /// Execute SwiftKitCLI
    func execute() {
        // Print ASCII art
        self.cli.stdout <<< .asciiArt
        // Start CLI
        _ = self.cli.go()
    }
    
}

// MARK: - Commands

private extension SwiftKitCLI {
    
    /// The Commands
    var commands: [Command] {
        return [
            NewCommand(
                kitService: self.swiftKit.kitService
            ),
            UpdateCommand(
                updateService: self.swiftKit.updateService
            )
        ]
    }
    
}

// MARK: - Executable

extension SwiftKitCLI: Executable {
    
    /// Execute the command
    ///
    /// - Parameter command: The command that should be executed
    /// - Returns: The corresponding output
    /// - Throws: If execution fails
    @discardableResult
    func execute(_ command: String) throws -> String {
        do {
            // Try to execute command and capture output
            return try SwiftCLI.Task.capture(bash: command).stdout
        } catch {
            // Check if Error is a SwiftCLI CaptureError
            if let captureError = error as? SwiftCLI.CaptureError {
                // Initialize SwiftKit Error
                let swiftKitError = SwiftKitError(
                    reason: "Command execution failed: \(command)",
                    error: captureError.message ?? ""
                )
                // Throw SwiftKitError
                throw swiftKitError
            } else {
                // Throw Error
                throw error
            }
        }
    }
    
    /// Print text
    ///
    /// - Parameter text: The text that should be printed out
    func print(_ text: String) {
        self.cli.stdout <<< text
    }
    
    /// Print error
    ///
    /// - Parameter text: The text that should be printed out
    func printError(_ text: String) {
        self.cli.stderr <<< text
    }
    
    /// Start loading
    ///
    /// - Parameter message: The optional message
    func startLoading(message: String?) {
        if let message = message {
            self.cliSpinner.start(message: message)
        } else {
            self.cliSpinner.start()
        }
    }
    
    /// Stop loading
    ///
    /// - Parameter message: The optional message
    func stopLoading(message: String?) {
        self.cliSpinner.stop(message: message)
    }
    
    /// Read line
    ///
    /// - Parameter prompt: The optional prompt text
    /// - Returns: The retrieved line if available
    func readLine(prompt: String?) -> String? {
        // Retrieve line
        let line = SwiftCLI.Input.readLine(prompt: prompt)
        // Verify line is not empty after trimming whitespaces
        guard !line.trimmingCharacters(in: .whitespaces).isEmpty else {
            // Line is empty return nil
            return nil
        }
        // Return line
        return line
    }
    
    /// Terminate Executable
    func terminate() {
        exit(0)
    }
    
}

// MARK: - String+ASCIIArt

private extension String {
    
    /// The ASCII Art
    static var asciiArt: String {
        return #"""
         ____          _  __ _   _  ___ _
        / ___|_      _(_)/ _| |_| |/ (_) |_
        \___ \ \ /\ / / | |_| __| ' /| | __|
         ___) \ V  V /| |  _| |_| . \| | |_
        |____/ \_/\_/ |_|_|  \__|_|\_\_|\__|
        
        """#
    }
    
}

// MARK: - String+Error

extension String: Error {}
