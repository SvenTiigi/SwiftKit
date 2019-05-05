//
//  SwiftKitCLI.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation
import SwiftCLI
import SwiftKit

// MARK: - SwiftKitCLI

/// The SwiftKitCLI
final class SwiftKitCLI {
    
    /// The SwiftKit
    private lazy var swiftKit = SwiftKit(
        executable: self
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
    
    /// Start the SwiftKitCLI
    func start() {
        // Print ASCII art
        self.cli.stdout <<< .asciiArt
        // Switch on Environment
        switch self.swiftKit.environment {
        case .production, .development:
            // Start CLI
            _ = self.cli.go()
        case .test:
            // Start CLI in Debug Mode
            _ = self.cli.debugGo(with: "swiftkit new")
        }
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
        return try SwiftCLI.capture(bash: command).stdout
    }
    
    /// Print text
    ///
    /// - Parameter text: The text that should be printed out
    func print(_ text: String) {
        self.cli.stdout <<< text
    }
    
    /// Print an Error
    ///
    /// - Parameter error: The Error that should be printed out
    func print(error: Error) {
        self.cli.stderr <<< error.localizedDescription
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
    
    /// Terminate CLI
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
