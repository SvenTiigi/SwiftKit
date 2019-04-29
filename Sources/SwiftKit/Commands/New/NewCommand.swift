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
    
    // MARK: Flags & Keys
    
    /// The destination Flag
    let destinationFlag = Key<String>(
        "-d", "--destination",
        description: "Where the generated Kit should be saved"
    )
    
    /// The project name Flag
    let projectNameFlag = Key<String>(
        "-p", "--project",
        description: "The project name of your Kit"
    )
    
    /// The author name Flag
    let authorNameFlag = Key<String>(
        "-n", "--name",
        description: "Your name"
    )
    
    /// The author email Flag
    let authorEmailFlag = Key<String>(
        "-e", "--email",
        description: "Your email address"
    )
    
    /// The repository URL Flag
    let repositoryURLFlag = Key<String>(
        "-u", "--url",
        description: "The repository url"
    )
    
    /// The organization name Flags
    let organizationNameFlag = Key<String>(
        "-o", "--organization",
        description: "The name of your organization"
    )
    
    /// The organization identifier Flag
    let organizationIdentifierFlag = Key<String>(
        "-oi", "--organization-identifier",
        description: "The organization identifier"
    )
    
    /// The force Flag
    let forceFlag = Flag(
        "-f", "--force",
        description: "Generate the Kit without confirmation"
    )
    
    /// The open project Flag
    let openProjectFlag = Flag(
        "-o", "--open",
        description: "Opens the the Xcode project of your generated Kit"
    )
    
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
    
    /// Executes the command
    ///
    /// - Throws: CLI.Error if command cannot execute successfully
    func execute() throws {
        // Print Bootstrap
        self.printBootstrap()
        // Check if the DestinationFlag Value is available
        if let destinationFlagValue = self.destinationFlag.value {
            // Set Project Path with DestinationFlag Value
            self.projectDirectory.path = destinationFlagValue
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
        let projectName = self.projectNameFlag.value ?? ProjectNameQuestion(
            projectDirectory: self.projectDirectory
        ).ask(on: self)
        // Initialize AuthorName
        let authorName = self.authorNameFlag.value ?? AuthorNameQuestion(
            gitConfigService: self.gitConfigService
        ).ask(on: self)
        // Initialiuze AuthorEmail
        let authorEmail = self.authorEmailFlag.value ?? AuthorEmailQuestion(
            gitConfigService: self.gitConfigService
        ).ask(on: self)
        // Initialize RepositoryURL
        let repositoryURL = self.repositoryURLFlag.value ?? RepositoryURLQuestion(
            projectDirectory: self.projectDirectory,
            gitConfigService: self.gitConfigService,
            projectName: projectName,
            authorName: authorName
        ).ask(on: self)
        // Initialize OrganizationName
        let organizationName = self.organizationNameFlag.value ?? OrganizationNameQuestion(
            projectName: projectName
        ).ask(on: self)
        // Initialize OrganizationIdentifier
        let organizationIdentifier = self.organizationIdentifierFlag.value ?? OrganizationIdentifierQuestion(
            projectName: projectName
        ).ask(on: self)
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
        // Check if ForceFlag is not present
        if !self.forceFlag.isPresent {
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
        // Verify if OpenProject Flag is present
        guard self.openProjectFlag.isPresent else {
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
