//
//  SwiftKit.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 28.04.19.
//

import Foundation
import SwiftCLI

// MARK: - SwiftKit

/// The SwiftKit
struct SwiftKit {
    
    // MARK: Properties
    
    /// The Version
    let version: String = "1.1.1"
    
    /// The CLI Name
    let cliName: String = "swiftkit"
    
    /// The Environment
    let environment: Environment
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameter environment: The Environment. Default value `production`
    init(environment: Environment = .production) {
        self.environment = environment
    }
    
}

// MARK: - Environment

extension SwiftKit {
    
    /// The Environment
    enum Environment: String, Codable, Equatable, Hashable, CaseIterable {
        /// Production
        case production
        /// Development
        case development
    }
    
}

// MARK: - Start

extension SwiftKit {
    
    /// Start SwiftKit
    func start() {
        // Initialize the CLI
        let cli = SwiftCLI.CLI(
            name: self.cliName,
            version: self.version,
            commands: self.commands
        )
        // Switch on Environment
        switch self.environment {
        case .production:
            // Start CLI
            _ = cli.go()
        case .development:
            // Start CLI in Debug Mode
            _ = cli.debugGo(with: "swiftkit new MyDevKit")
        }
    }
    
}

// MARK: - Commands

private extension SwiftKit {
    
    /// The Commands
    var commands: [Command] {
        switch self.environment {
        case .production:
            return [
                NewCommand(
                    gitConfigService: SwiftCLIGitConfigService(),
                    templateCloneService: DefaultTemplateCloneService(),
                    templatePlaceholderMigrationService: DefaultTemplatePlaceholderMigrationService()
                )
            ]
        case .development:
            return [
                NewCommand(
                    gitConfigService: SwiftCLIGitConfigService(),
                    templateCloneService: EmptyTemplateCloneService(),
                    templatePlaceholderMigrationService: EmptyTemplatePlaceholderMigrationService()
                )
            ]
        }
    }
    
}
