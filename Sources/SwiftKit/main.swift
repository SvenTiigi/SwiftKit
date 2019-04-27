//
//  main.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 27.04.19.
//

import SwiftCLI

// Initialize the CLI
let cli = CLI(
    name: "swiftkit",
    version: "1.0.0"
)

// Set Commands
cli.commands = [
    NewCommand(
        gitConfigService: SwiftCLIGitConfigService(),
        templateCloneService: DefaultTemplateCloneService(),
        templatePlaceholderMigrationService: DefaultTemplatePlaceholderMigrationService()
    )
]

/// Start CLI
_ = cli.debugGo(with: "swiftkit new")
