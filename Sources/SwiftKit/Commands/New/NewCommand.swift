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
    
    // MARK: Parameters
    
    /// The optional ProjectName Parameter
    let projectNameParameter = OptionalParameter()
    
    // MARK: Arguments
    
    /// The destination Argument
    let destinationArgument = Argument.destination
    
    /// The project name Argument
    let projectNameArgument = Argument.projectName
    
    /// The author name Argument
    let authorNameArgument = Argument.authorName
    
    /// The author email Argument
    let authorEmailArgument = Argument.authorEmail
    
    /// The repository URL Argument
    let repositoryURLArgument = Argument.repositoryURL
    
    /// The organization name Argument
    let organizationNameArgument = Argument.organizationName
    
    /// The organization identifier Argument
    let organizationIdentifierArgument = Argument.organizationIdentifier
    
    /// The force Argument
    let forceArgument = Argument.force
    
    /// The open project Argument
    let openProjectArgument = Argument.openProject
    
    // MARK: Properties
    
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
    
    /// A concise description of what this command or group is
    var shortDescription: String {
        return "Generate a new Kit"
    }
    
    /// A longer description of how to use this command or group
    var longDescription: String {
        return self.shortDescription
    }
    
    /// Executes the command
    ///
    /// - Throws: CLI.Error if command cannot execute successfully
    func execute() throws {
        // Print Bootstrap
        self.printBootstrap()
        // Check if the Destination Argument Value is available
        if let destinationArgumentValue = self.destinationArgument.value {
            // Set Project Path with Destination Argument Value
            self.projectDirectory.path = destinationArgumentValue
            // Check if the last character is a slash
            if self.projectDirectory.path.last == "/" {
                // Drop the last slash
                self.projectDirectory.path = .init(self.projectDirectory.path.dropLast())
            }
        }
        // Check if a ProjectName Parameter value is available
        if let projectNameParameterValue = self.projectNameParameter.value {
            // Append value to ProjectDirectory Path
            self.projectDirectory.path += "/\(projectNameParameterValue)"
        }
        // Initialize ProjectName
        let projectName = self.projectNameParameter.value ?? self.projectNameArgument.value ?? ProjectNameQuestion(
            projectDirectory: self.projectDirectory
        ).ask(on: self)
        // Initialize AuthorName
        let authorName = self.authorNameArgument.value ?? AuthorNameQuestion(
            gitConfigService: self.gitConfigService
        ).ask(on: self)
        // Initialiuze AuthorEmail
        let authorEmail = self.authorEmailArgument.value ?? AuthorEmailQuestion(
            gitConfigService: self.gitConfigService
        ).ask(on: self)
        // Initialize RepositoryURL
        let repositoryURL = self.repositoryURLArgument.value ?? RepositoryURLQuestion(
            projectDirectory: self.projectDirectory,
            gitConfigService: self.gitConfigService,
            projectName: projectName,
            authorName: authorName
        ).ask(on: self)
        // Initialize OrganizationName
        let organizationName = self.organizationNameArgument.value ?? OrganizationNameQuestion(
            projectName: projectName
        ).ask(on: self)
        // Initialize OrganizationIdentifier
        let organizationIdentifier = self.organizationIdentifierArgument.value ?? OrganizationIdentifierQuestion(
            projectName: projectName
        ).ask(on: self)
        // Initialize CIService
        let ciService = CIService(rawValue: CIServiceQuestion().ask(on: self)) ?? .none
        // Initialize TemplatePlacerholder
        let templatePlaceholder = TemplatePlaceholder(
            projectName: projectName,
            authorName: authorName,
            authorEmail: authorEmail,
            repositoryURL: repositoryURL,
            organizationName: organizationName,
            organizationIdentifier: organizationIdentifier,
            ciService: ciService
        )
        // Print Summary
        self.printSummary(
            with: templatePlaceholder,
            projectDirectory: self.projectDirectory
        )
        // Check if Force Argument is not present
        if !self.forceArgument.isPresent {
            // Ask for Generate
            self.askForGenerate(projectName: projectName)
        }
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
        // Verify if OpenProject Argument is present
        guard self.openProjectArgument.isPresent else {
            // Return out of function as nothing left to do
            return
        }
        try? run(bash: "open \(self.projectDirectory.path)/\(projectName).xcodeproj")
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
        stdout <<< "ℹ️  Organization Identifier: \(templatePlaceholder.organizationIdentifier)"
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
