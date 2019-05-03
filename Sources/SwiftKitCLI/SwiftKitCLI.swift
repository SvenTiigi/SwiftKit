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
                generateKitDialogService: self.generatedKitDialogService,
                openGeneratedKitService: self.openGeneratedKitService,
                updateNotifierService: self.updateNotifierService
            ),
            UpdateCommand(
                packageManagerService: self.packageManagerService,
                updateCheckService: self.swiftKit.updateCheckService,
                currentVersion: SwiftKitCLI.version
            )
        ]
    }
    
}

// MARK: - Services

private extension SwiftKitCLI {
    
    /// The GenerateKitDialogService
    var generatedKitDialogService: GenerateKitDialogService {
        return SwiftCLIGenerateKitDialogService(
            gitService: self.swiftKit.gitService,
            kitService: self.swiftKit.kitService,
            cocoaPodsService: self.swiftKit.cocoaPodsService
        )
    }
    
    /// The OpenGeneratedKitService
    var openGeneratedKitService: OpenGeneratedKitService {
        return SwiftCLIOpenGeneratedKitService()
    }
    
    /// The UpdateNotifierService
    var updateNotifierService: UpdateNotifierService {
        return SwiftKitUpdateNotifierService(
            currentVersion: SwiftKitCLI.version,
            updateCheckService: self.swiftKit.updateCheckService
        )
    }
    
    /// The PackageManagerService
    var packageManagerService: PackageManagerService {
        return DefaultPackageManagerService()
    }
    
}
