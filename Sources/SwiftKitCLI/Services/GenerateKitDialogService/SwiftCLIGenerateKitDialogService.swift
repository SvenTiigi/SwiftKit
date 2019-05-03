//
//  SwiftCLIGenerateKitDialogService.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 03.05.19.
//

import Foundation
import Motor
import SwiftCLI
import SwiftKit

// MARK: - SwiftCLIGenerateKitDialogService

/// The SwiftCLIGenerateKitDialogService
final class SwiftCLIGenerateKitDialogService {
    
    // MARK: Properties
    
    /// The Kit Directory
    var kitDirectory: Kit.Directory
    
    /// The GitService
    let gitService: GitService
    
    /// The KitService
    let kitService: KitService
    
    /// The CocoaPodsService
    let cocoaPodsService: CocoaPodsService
    
    /// The Spinner
    let spinner = Spinner(pattern: Patterns.dots)
    
    /// Bool if pod is available
    var isPodAvailable: Bool?
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - kitDirectory: The Kit Directory. Default value `.default()`
    ///   - gitService: The GitService
    ///   - kitService: The KitService
    ///   - cocoaPodsService: The CocoaPodsService
    init(kitDirectory: Kit.Directory = .default(),
         gitService: GitService,
         kitService: KitService,
         cocoaPodsService: CocoaPodsService) {
        self.kitDirectory = kitDirectory
        self.gitService = gitService
        self.kitService = kitService
        self.cocoaPodsService = cocoaPodsService
    }
    
}

// MARK: - GenerateKitDialogService

extension SwiftCLIGenerateKitDialogService: GenerateKitDialogService {
    
    /// Start genertate Kit dialog
    ///
    /// - Parameter command: The NewCommand
    /// - Returns: A Result
    func start(on command: NewCommand) -> Result<GeneratedKit, Error> {
        // Check if the Destination Argument Value is available
        if let destinationArgumentValue = command.destinationArgument.value {
            // Set Kit Directory Path with Destination Argument Value
            self.kitDirectory.path = destinationArgumentValue
            // Check if the last character is a slash
            if self.kitDirectory.path.last == "/" {
                // Drop the last slash
                self.kitDirectory.path = .init(self.kitDirectory.path.dropLast())
            }
        }
        // Check if a Kit name Parameter value is available
        if let kitName = command.kitNameParameter.value {
            // Append Kit name to Kit Directory Path
            self.kitDirectory.path += "/\(kitName)"
        }
        // Start Kit Dialog and retrieve Kit
        let kit = self.startKitDialog(on: command)
        // Print Summary
        self.printSummary(
            on: command,
            with: kit,
            at: self.kitDirectory
        )
        // Print Warnings if needed
        self.printWarningsIfNeeded(on: command, for: kit)
        // Check if Force Argument is not present
        if !command.forceArgument.isPresent {
            // Switch on lowercased GenerateKit question answer
            switch GenerateKitQuestion(kitName: kit.name).ask(on: command).lowercased() {
            case "n":
                // Print bye
                command.stdout <<< "Bye bye 👋"
                // Exit program
                exit(0)
            default:
                // Do nothing
                break
            }
            
        }
        // Print Start
        self.printStart(with: kit)
        do {
            // Try to generate Kit
            try self.kitService.generate(kit: kit, at: self.kitDirectory)
        } catch {
            // Print cached error
            self.print(on: command, error: error)
            // Return failure
            return .failure(error)
        }
        // Print Finish
        self.printFinish(with: kit)
        // Return success with Kit Directory
        return .success(.init(kit: kit, directory: self.kitDirectory))
    }
    
}

// MARK: - Start Kit Dialog

extension SwiftCLIGenerateKitDialogService {
    
    /// Start Kit dialog and retrieve Kit
    ///
    /// - Parameter command: The NewCommand
    /// - Returns: The Kit
    func startKitDialog(on command: NewCommand) -> Kit {
        // 1. Initialize Kit name
        let kitName = command.kitNameParameter.value ?? command.kitNameArgument.value ?? KitNameQuestion(
            kitDirectory: self.kitDirectory
        ).ask(on: command)
        // Check for CocoaPod with name
        self.checkForCocoaPod(name: kitName)
        // 2. Initialize AuthorName
        let authorName = command.authorNameArgument.value ?? AuthorNameQuestion(
            gitService: self.gitService
        ).ask(on: command)
        // 3. Initialize AuthorEmail
        let authorEmail = command.authorEmailArgument.value ?? AuthorEmailQuestion(
            gitService: self.gitService
        ).ask(on: command)
        // 4. Initialize RepositoryURL
        let repositoryURL = command.repositoryURLArgument.value ?? RepositoryURLQuestion(
            kitDirectory: self.kitDirectory,
            gitService: self.gitService,
            kitName: kitName,
            authorName: authorName
        ).ask(on: command)
        // 5. Initialize CIService
        let ciService = CIService(
            rawValue: command.ciServiceArgument.value ?? CIServiceQuestion().ask(on: command)
        )
        // 6. Initialize OrganizationName
        let organizationName = command.organizationNameArgument.value ?? OrganizationNameQuestion(
            kitName: kitName
        ).ask(on: command)
        // 7. Initialize OrganizationIdentifier
        let organizationIdentifier = command.organizationIdentifierArgument.value ?? OrganizationIdentifierQuestion(
            organizationName: organizationName,
            kitName: kitName
        ).ask(on: command)
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

// MARK: - Check for CocoaPod

extension SwiftCLIGenerateKitDialogService {
    
    /// Check for CocoaPod name availability
    ///
    /// - Parameter name: The Pod name
    func checkForCocoaPod(name: String) {
        // Dispatch on background queue as isPodAvailable API might take some time
        DispatchQueue.global().async { [weak self] in
            // Set isPodAvailable
            self?.isPodAvailable = self?.cocoaPodsService.isPodAvailable(forName: name)
        }
    }
    
}

// MARK: - Prints

extension SwiftCLIGenerateKitDialogService {
    
    /// Print Summary
    ///
    /// - Parameters:
    ///   - kit: The Kit
    ///   - directory: The Kit Directory
    func printSummary(on command: Command, with kit: Kit, at directory: Kit.Directory) {
        command.stdout <<< "\(kit.name) Summary:"
        command.stdout <<< .dividerLine
        command.stdout <<< "💾  Destination: \(directory.path)"
        command.stdout <<< "📦  Kit Name: \(kit.name)"
        command.stdout <<< "👨‍💻  Author: \(kit.author.name)"
        if !kit.author.email.isEmpty {
            command.stdout <<< "📫  E-Mail: \(kit.author.email)"
        }
        if !kit.repositoryURL.isEmpty {
            command.stdout <<< "🌎  Repository URL: \(kit.repositoryURL)"
        }
        command.stdout <<< "🏢  Organization: \(kit.organization.name)"
        command.stdout <<< "🖋   Organization Identifier: \(kit.organization.identifier)"
        if let ciService = kit.ciService {
            command.stdout <<< "🛠   CI-Service: \(ciService.displayName)"
        }
        command.stdout <<< .dividerLine
        command.stdout <<< ""
    }
    
    /// Print Warnings if needed
    ///
    /// - Parameter kit: The Kit
    func printWarningsIfNeeded(on command: Command, for kit: Kit) {
        if let isPodAvailable = self.isPodAvailable, isPodAvailable {
            command.stdout <<< "Warnings:"
            command.stdout <<< "⚠️   CocoaPods: Pod with name \"\(kit.name)\" is already taken"
            command.stdout <<< ""
        }
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
    func print(on command: Command, error: Error) {
        // Stop the Spinner
        self.spinner.stop()
        // Print Error
        command.stderr <<< error.localizedDescription
    }
    
}
