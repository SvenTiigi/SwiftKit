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
class SwiftKitCLI {
    
    // MARK: Properties
    
    /// The SwiftKit Environment
    let environment: SwiftKit.Environment
    
    /// The Version
    let version: String = "1.2.0"
    
    /// The CLI Name
    let cliName: String = "swiftkit"
    
    /// The SwiftKit
    lazy var swiftKit = SwiftKit(
        environment: self.environment
    )
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameter environment: The SwiftKit Environment
    init(environment: SwiftKit.Environment) {
        self.environment = environment
    }
    
}

// MARK: - Start

extension SwiftKitCLI {
    
    /// Start the SwiftKitCLI
    func start() {
        // Initialize the CLI
        let cli = SwiftCLI.CLI(
            name: self.cliName,
            version: self.version,
            commands: self.commands
        )
        // Switch on Environment
        switch self.environment {
        case .production, .development:
            // Start CLI
            _ = cli.go()
        case .test:
            // Start CLI in Debug Mode
            _ = cli.debugGo(with: "swiftkit new MyTestKit")
        }
    }
    
}

// MARK: - Commands

private extension SwiftKitCLI {
    
    /// The Commands
    var commands: [Command] {
        return [
            NewCommand(
                gitService: self.swiftKit.gitService,
                kitService: self.swiftKit.kitService
            )
        ]
    }
    
}
