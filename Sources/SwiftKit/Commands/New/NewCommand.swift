//
//  NewCommand.swift
//  Kit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation
import SwiftCLI
import Motor

// MARK: - NewCommand

/// The NewCommand
class NewCommand {
    
    // MARK: Properties
    
    /// The optional ProjectName Parameter
    let projectNameParameter = OptionalParameter()
    
    /// The ProjectDirectory
    var projectDirectory: ProjectDirectory

    /// The GitConfigService
    let gitConfigService: GitConfigService
    
    /// The TemplateCloneService
    let templateCloneService: TemplateCloneService
    
    /// The TemplatePlaceholderMigrationService
    let templatePlaceholderMigrationService: TemplatePlaceholderMigrationService
    
    /// The Spinner
    let spinner = Spinner(pattern: Patterns.dots)
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - projectDirectory: The ProjectDirectory. Default value `.init`
    ///   - gitConfigService: The GitConfigService
    ///   - templateCloneService: The TemplateCloneService
    ///   - templatePlaceholderMigrationService: The TemplatePlaceholderMigrationService
    init(projectDirectory: ProjectDirectory = .init(),
         gitConfigService: GitConfigService,
         templateCloneService: TemplateCloneService,
         templatePlaceholderMigrationService: TemplatePlaceholderMigrationService) {
        self.projectDirectory = projectDirectory
        self.gitConfigService = gitConfigService
        self.templateCloneService = templateCloneService
        self.templatePlaceholderMigrationService = templatePlaceholderMigrationService
    }
    
}

// MARK: - Command

extension NewCommand: Command {
    
    /// The name
    var name: String {
        return "new"
    }
    
    /// Executes the command
    ///
    /// - Throws: CLI.Error if command cannot execute successfully
    func execute() throws {
        // Print Bootstrap
        self.printBootstrap()
        // Check if a ProjectName Parameter value is available
        if let projectNameParameterValue = self.projectNameParameter.value {
            // Append value to ProjectDirectory Path
            self.projectDirectory.path += "/\(projectNameParameterValue)"
        }
        // Initialize ProjectName
        let projectName = ProjectNameQuestion(projectDirectory: self.projectDirectory).ask(on: self)
        // Initialize AuthorName
        let authorName = AuthorNameQuestion(gitConfigService: self.gitConfigService).ask(on: self)
        // Initialiuze AuthorEmail
        let authorEmail = AuthorEmailQuestion(gitConfigService: self.gitConfigService).ask(on: self)
        // Initialize RepositoryURL
        let repositoryURL = RepositoryURLQuestion(
            projectDirectory: self.projectDirectory,
            gitConfigService: self.gitConfigService,
            projectName: projectName,
            authorName: authorName
        ).ask(on: self)
        // Initialize OrganizationName
        let organizationName = OrganizationNameQuestion(projectName: projectName).ask(on: self)
        // Initialize OrganizationIdentifier
        let organizationIdentifier = OrganizationIdentifierQuestion(projectName: projectName).ask(on: self)
        // Initialize TemplatePlacerholder
        let templatePlaceholder = TemplatePlaceholder(
            projectName: projectName,
            authorName: authorName,
            authorEmail: authorEmail,
            repositoryURL: repositoryURL,
            organizationName: organizationName,
            organizationIdentifier: organizationIdentifier
        )
        // Print Summary
        self.printSummary(
            with: templatePlaceholder,
            projectDirectory: self.projectDirectory
        )
        // Ask for Generate
        self.askForGenerate(projectName: projectName)
        // Print Start
        self.printStart(with: templatePlaceholder)
        // Clone Template
        try self.templateCloneService.clone(atPath: self.projectDirectory.path)
        /// Migrate Template
        self.templatePlaceholderMigrationService.migrate(
            atPath: self.projectDirectory.path,
            placeholder: templatePlaceholder
        )
        // Print Finish
        self.printFinish(with: templatePlaceholder)
    }
    
}

// MARK: - Prints

extension NewCommand {

    /// Print Bootstrap
    func printBootstrap() {
        // Print out ASCII Art
        stdout <<< .asciiArt
    }
    
    /// Print Summary
    ///
    /// - Parameter templatePlaceholder: The TemplatePlaceholder
    func printSummary(with templatePlaceholder: TemplatePlaceholder, projectDirectory: ProjectDirectory) {
        stdout <<< "\(templatePlaceholder.projectName) Summary:"
        stdout <<< "---------------------------------------------------------------------"
        stdout <<< "💾  Destination: \(projectDirectory.path)"
        stdout <<< "🐣  Project Name: \(templatePlaceholder.projectName)"
        stdout <<< "👨‍💻  Author: \(templatePlaceholder.authorName)"
        if !templatePlaceholder.authorEmail.isEmpty {
            stdout <<< "📫  E-Mail: \(templatePlaceholder.authorEmail)"
        }
        if !templatePlaceholder.repositoryURL.isEmpty {
            stdout <<< "🌎  Repository URL: \(templatePlaceholder.repositoryURL)"
        }
        stdout <<< "🏢  Organization: \(templatePlaceholder.organizationName)"
        stdout <<< "📦  Organization Identifier: \(templatePlaceholder.organizationIdentifier)"
        stdout <<< "---------------------------------------------------------------------"
        stdout <<< ""
    }
    
    /// Print Start
    ///
    /// - Parameter templatePlaceholder: The TemplatePlaceholder
    func printStart(with templatePlaceholder: TemplatePlaceholder) {
        // Start Spinner with message
        self.spinner.start(
            message: "Generating \(templatePlaceholder.projectName)"
        )
    }
    
    /// Print Finish
    ///
    /// - Parameter templatePlaceholder: The TemplatePlaceholder
    func printFinish(with templatePlaceholder: TemplatePlaceholder) {
        // Stop Spinner with message
        self.spinner.stop(
            message: "\(templatePlaceholder.projectName) is ready to go 🚀"
        )
    }
    
}

// MARK: - Ask

extension NewCommand {
    
    /// Ask for Generate
    func askForGenerate(projectName: String) {
        // swiftlint:disable nesting
        /// The Generate Question
        struct GenerateQuestion: Question {
            let projectName: String
            var questionVariant: QuestionVariant {
                return .required(
                    text: "Generate \(self.projectName)? ✅\nPlease enter Y/y (yes) or N/n (no)"
                )
            }
        }
        // swiftlint:enable nesting
        // Initialize GenerateQuestion
        let question = GenerateQuestion(projectName: projectName)
        // Switch on lowercased answer
        switch question.ask(on: self).lowercased() {
        case "y":
            // Do nothing
            break
        case "n":
            // Print bye
            stdout <<< "Bye bye 👋"
            // Exit program
            exit(0)
        default:
            // Print try again
            stdout <<< "Please try again"
            // Re-Invoke ask for generate
            self.askForGenerate(projectName: projectName)
        }
    }
    
}
