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
    
    // MARK: Properties
    
    /// The SwiftKit Environment
    static let environment: SwiftKit.Environment = .production
    
    /// The Version
    static let version: Version = "1.2.0"
    
    /// The CLI Name
    let cliName: String = "swiftkit"
    
    /// The SwiftKit
    lazy var swiftKit = SwiftKit(
        environment: SwiftKitCLI.environment
    )
    
}

// MARK: - Start

extension SwiftKitCLI {
    
    /// Start the SwiftKitCLI
    func start() {
        // Initialize the CLI
        let cli = SwiftCLI.CLI(
            name: self.cliName,
            version: SwiftKitCLI.version.description,
            commands: self.commands
        )
        // Switch on Environment
        switch SwiftKitCLI.environment {
        case .production, .development:
            // Start CLI
            _ = cli.go()
        case .test:
            // Start CLI in Debug Mode
            _ = cli.debugGo(with: "swiftkit new")
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
                kitService: self.swiftKit.kitService,
                updateCheckService: self.swiftKit.updateCheckService,
                version: SwiftKitCLI.version
            ),
            UpdateCommand(
                packageManagerService: DefaultPackageManagerService(),
                updateCheckService: self.swiftKit.updateCheckService,
                version: SwiftKitCLI.version
            )
        ]
    }
    
}
