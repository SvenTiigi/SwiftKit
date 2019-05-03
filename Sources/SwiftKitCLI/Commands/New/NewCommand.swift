//
//  NewCommand.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation
import Motor
import SwiftCLI
import SwiftKit

// MARK: - NewCommand

/// The NewCommand
final class NewCommand {
    
    // MARK: Parameters
    
    /// The optional Kit Name Parameter
    let kitNameParameter = OptionalParameter()
    
    // MARK: Arguments
    
    /// The destination Argument
    let destinationArgument = Argument.destination
    
    /// The Kit name Argument
    let kitNameArgument = Argument.kitName
    
    /// The author name Argument
    let authorNameArgument = Argument.authorName
    
    /// The author email Argument
    let authorEmailArgument = Argument.authorEmail
    
    /// The repository URL Argument
    let repositoryURLArgument = Argument.repositoryURL
    
    /// The CIService Argument
    let ciServiceArgument = Argument.ciService
    
    /// The organization name Argument
    let organizationNameArgument = Argument.organizationName
    
    /// The organization identifier Argument
    let organizationIdentifierArgument = Argument.organizationIdentifier
    
    /// The force Argument
    let forceArgument = Argument.force
    
    /// The open project Argument
    let openProjectArgument = Argument.openProject
    
    // MARK: Properties
    
    /// The Kit Directory
    var kitDirectory: Kit.Directory
    
    /// The GitService
    let gitService: GitService
    
    /// The KitService
    let kitService: KitService
    
    /// The UpdateCheckService
    let updateCheckService: UpdateCheckService
    
    /// The Version
    let version: Version
    
    /// The Spinner
    let spinner = Spinner(pattern: Patterns.dots)
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - kitDirectory: The Kit Directory. Default value `.default()`
    ///   - gitService: The GitService
    ///   - kitService: The KitService
    ///   - updateCheckService: The UpdateCheckService
    ///   - version: The Version
    init(kitDirectory: Kit.Directory = .default(),
         gitService: GitService,
         kitService: KitService,
         updateCheckService: UpdateCheckService,
         version: Version) {
        self.kitDirectory = kitDirectory
        self.gitService = gitService
        self.kitService = kitService
        self.updateCheckService = updateCheckService
        self.version = version
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
            // Set Kit Directory Path with Destination Argument Value
            self.kitDirectory.path = destinationArgumentValue
            // Check if the last character is a slash
            if self.kitDirectory.path.last == "/" {
                // Drop the last slash
                self.kitDirectory.path = .init(self.kitDirectory.path.dropLast())
            }
        }
        // Check if a Kit name Parameter value is available
        if let kitName = self.kitNameParameter.value {
            // Append Kit name to Kit Directory Path
            self.kitDirectory.path += "/\(kitName)"
        }
        // Make Kit
        let kit = self.makeKit()
        // Print Summary
        self.printSummary(
            with: kit,
            at: self.kitDirectory
        )
        // Check if Force Argument is not present
        if !self.forceArgument.isPresent {
            // Ask for Generate
            self.askForGenerate(kitName: kit.name)
        }
        // Print Start
        self.printStart(with: kit)
        do {
            // Try to generate Kit
            try self.kitService.generate(kit: kit, at: self.kitDirectory)
        } catch {
            // Print cached error
            self.print(error: error)
            // Return out of function as nothing left to do
            return
        }
        // Print Finish
        self.printFinish(with: kit)
        // Verify if OpenProject Argument is present
        if self.openProjectArgument.isPresent {
            // Open the Xcode Project
            try? run(bash: "open \(self.kitDirectory.path)/\(kit.name).xcodeproj")
        }
        // Check if an Update is available
        if case let .some(.available(version)) = self.updateCheckService.check(version: self.version) {
            // Print out that a new version is available
            stdout <<< "\nA new version of SwiftKit is available: \(version)"
            // Print out update instructions
            stdout <<< "To update SwiftKit run: swiftkit update"
        }
    }

}

// MARK: - Make Kit

extension NewCommand {
    
    /// Make Kit
    ///
    /// - Returns: The Kit
    func makeKit() -> Kit {
        // 1. Initialize Kit name
        let kitName = self.kitNameParameter.value ?? self.kitNameArgument.value ?? KitNameQuestion(
            kitDirectory: self.kitDirectory
        ).ask(on: self)
        // 2. Initialize AuthorName
        let authorName = self.authorNameArgument.value ?? AuthorNameQuestion(
            gitService: self.gitService
        ).ask(on: self)
        // 3. Initialize AuthorEmail
        let authorEmail = self.authorEmailArgument.value ?? AuthorEmailQuestion(
            gitService: self.gitService
        ).ask(on: self)
        // 4. Initialize RepositoryURL
        let repositoryURL = self.repositoryURLArgument.value ?? RepositoryURLQuestion(
            kitDirectory: self.kitDirectory,
            gitService: self.gitService,
            kitName: kitName,
            authorName: authorName
        ).ask(on: self)
        // 5. Initialize CIService
        let ciService = CIService(rawValue: self.ciServiceArgument.value ?? CIServiceQuestion().ask(on: self))
        // 6. Initialize OrganizationName
        let organizationName = self.organizationNameArgument.value ?? OrganizationNameQuestion(
            kitName: kitName
        ).ask(on: self)
        // 7. Initialize OrganizationIdentifier
        let organizationIdentifier = self.organizationIdentifierArgument.value ?? OrganizationIdentifierQuestion(
            organizationName: organizationName,
            kitName: kitName
        ).ask(on: self)
        // Return Kit
        return .init(
            name: kitName,
            author: .init(
                name: authorName,
                email: authorEmail
            ),
            repositoryURL: repositoryURL,
            organization: .init(
                name: organizationName,
                identifier: organizationIdentifier
            ),
            ciService: ciService
        )
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
    /// - Parameters:
    ///   - kit: The Kit
    ///   - directory: The Kit Directory
    func printSummary(with kit: Kit, at directory: Kit.Directory) {
        stdout <<< "\(kit.name) Summary:"
        stdout <<< .dividerLine
        stdout <<< "💾  Destination: \(directory.path)"
        stdout <<< "📦  Kit Name: \(kit.name)"
        stdout <<< "👨‍💻  Author: \(kit.author.name)"
        if !kit.author.email.isEmpty {
            stdout <<< "📫  E-Mail: \(kit.author.email)"
        }
        if !kit.repositoryURL.isEmpty {
            stdout <<< "🌎  Repository URL: \(kit.repositoryURL)"
        }
        stdout <<< "🏢  Organization: \(kit.organization.name)"
        stdout <<< "🖋   Organization Identifier: \(kit.organization.identifier)"
        if let ciService = kit.ciService {
            stdout <<< "🛠   CI-Service: \(ciService.displayName)"
        }
        stdout <<< .dividerLine
        stdout <<< ""
    }
    
    /// Print Start
    ///
    /// - Parameter kit: The Kit
    func printStart(with kit: Kit) {
        // Start Spinner with message
        self.spinner.start(
            message: "Generating \(kit.name)"
        )
    }
    
    /// Print Finish
    ///
    /// - Parameter kit: The Kit
    func printFinish(with kit: Kit) {
        // Stop Spinner with message
        self.spinner.stop(
            message: "\(kit.name) is ready to go 🚀"
        )
    }
    
    /// Print Error
    ///
    /// - Parameter error: The Error that should be printed
    func print(error: Error) {
        // Stop the Spinner
        self.spinner.stop()
        // Print Error
        stderr <<< error.localizedDescription
    }
    
}

// MARK: - Ask

extension NewCommand {
    
    /// Ask for Generate
    func askForGenerate(kitName: String) {
        // swiftlint:disable nesting
        /// The Generate Question
        struct GenerateQuestion: Question {
            let kitName: String
            var questionVariant: QuestionVariant {
                return .optional(
                    text: "Generate \(self.kitName)? ✅",
                    hint: "Simply hit enter or type N/n (no) to abort",
                    defaultAnswer: "y"
                )
            }
        }
        // swiftlint:enable nesting
        // Initialize GenerateQuestion
        let question = GenerateQuestion(kitName: kitName)
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
            // Do nothing
            break
        }
    }
    
}
