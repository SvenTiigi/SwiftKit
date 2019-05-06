//
//  DefaultKitService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Dispatch
import Foundation

// MARK: - DefaultKitService

/// The DefaultKitService
final class DefaultKitService {
    
    // MARK: Properties
    
    /// The Kit Directory
    var kitDirectory: Kit.Directory
    
    /// The Executable
    let executable: Executable
    
    /// The GitService
    let gitService: GitService
    
    /// The CocoaPodsService
    let cocoaPodsService: CocoaPodsService
    
    /// The KitSetupService
    let kitSetupService: KitSetupService
    
    /// The KitMigrationService
    let kitMigrationService: KitMigrationService
    
    /// The FileService
    let fileService: FileService
    
    /// The UpdateNotifierService
    let updateNotifierService: UpdateNotifierService
    
    /// The QuestionService
    let questionService: QuestionService
    
    /// Bool if pod is available
    var isPodAvailable: Bool?
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - kitDirectory: The Kit Directory
    ///   - executable: The Executable
    ///   - gitService: The GitService
    ///   - cocoaPodsService: The CocoaPodsService
    ///   - kitSetupService: The KitSetupService
    ///   - kitMigrationService: The KitMigrationService
    ///   - fileService: The FileService
    ///   - updateNotifierService: The UpdateNotifierService
    ///   - questionService: The QuestionService
    init(kitDirectory: Kit.Directory,
         executable: Executable,
         gitService: GitService,
         cocoaPodsService: CocoaPodsService,
         kitSetupService: KitSetupService,
         kitMigrationService: KitMigrationService,
         fileService: FileService,
         updateNotifierService: UpdateNotifierService,
         questionService: QuestionService) {
        self.kitDirectory = kitDirectory
        self.executable = executable
        self.gitService = gitService
        self.cocoaPodsService = cocoaPodsService
        self.kitSetupService = kitSetupService
        self.kitMigrationService = kitMigrationService
        self.fileService = fileService
        self.updateNotifierService = updateNotifierService
        self.questionService = questionService
    }
    
}

// MARK: - KitService

extension DefaultKitService: KitService {
    
    /// Create Kit
    ///
    /// - Parameter arguments: The KitCreationArguments
    func create(with arguments: KitCreationArguments) {
        // Check if the Destination Argument Value is available
        if let destinationArgumentValue = arguments.destinationArgument {
            // Set Kit Directory Path with Destination Argument Value
            self.kitDirectory.path = destinationArgumentValue
            // Check if the last character is a slash
            if self.kitDirectory.path.last == "/" {
                // Drop the last slash
                self.kitDirectory.path = .init(self.kitDirectory.path.dropLast())
            }
        }
        // Check if a Kit name Parameter value is available
        if let kitName = arguments.kitNameParameter {
            // Append Kit name to Kit Directory Path
            self.kitDirectory.path += "/\(kitName)"
        }
        // Make Kit with KitCreationArguments
        let kit = self.makeKit(with: arguments)
        // Print Summary
        self.printSummary(
            for: kit,
            at: self.kitDirectory
        )
        // Print Warnings if needed
        self.printWarningsIfNeeded(for: kit)
        // Check if Force Argument is not present
        if !arguments.forceArgument {
            // Switch on lowercased GenerateKit question answer
            switch self.questionService.ask(GenerateKitQuestion(kitName: kit.name)).lowercased() {
            case "n":
                // Print bye
                self.executable.print("Bye bye 👋")
                // Terminate CLI
                self.executable.terminate()
            default:
                // Do nothing
                break
            }
        }
        // Print Start
        self.printStart(with: kit)
        do {
            // Try to setup Kit
            try self.kitSetupService.setup(at: self.kitDirectory)
            // Try to migrate Kit
            try self.kitMigrationService.migrate(kit: kit, at: self.kitDirectory)
        } catch {
            // Print cached error
            self.print(error: error)
            // Return out of function
            return
        }
        // Print Finish
        self.printFinish(with: kit)
        // Verify if OpenProject Argument is present
        if arguments.openProjectArgument {
            // Open generated Kit project path
            self.fileService.open(atPath: "\(self.kitDirectory.path)/\(kit.name).xcodeproj")
        }
        // Notify about updates if needed
        self.updateNotifierService.notifyIfNeeded()
    }
    
}

// MARK: - Make Kit

extension DefaultKitService {
    
    // swiftlint:disable function_body_length
    /// Make Kit
    ///
    /// - Parameter arguments: The KitArguments
    /// - Returns: The Kit
    func makeKit(with arguments: KitCreationArguments) -> Kit {
        // 1. Initialize Kit name
        let kitName = self.questionService.ask(
            KitNameQuestion(
                kitDirectory: self.kitDirectory
            ),
            predefinedAnswer: arguments.kitNameParameter ?? arguments.kitNameArgument
        )
        // Check for CocoaPod with name
        self.checkForCocoaPod(name: kitName)
        // 2. Initialize AuthorName
        let authorName = self.questionService.ask(
            AuthorNameQuestion(
                gitService: self.gitService
            ),
            predefinedAnswer: arguments.authorNameArgument
        )
        // 3. Initialize AuthorEmail
        let authorEmail = self.questionService.ask(
            AuthorEmailQuestion(
                gitService: self.gitService
            ),
            predefinedAnswer: arguments.authorEmailArgument
        )
        // 4. Initialize RepositoryURL
        let repositoryURL = self.questionService.ask(
            RepositoryURLQuestion(
                kitDirectory: self.kitDirectory,
                gitService: self.gitService,
                kitName: kitName,
                authorName: authorName
            ),
            predefinedAnswer: arguments.repositoryURLArgument
        )
        // 5. Initialize CIService
        let ciService = Kit.CIService(
            rawValue: self.questionService.ask(
                CIServiceQuestion(),
                predefinedAnswer: arguments.ciServiceArgument
            )
        )
        // 6. Initialize OrganizationName
        let organizationName = self.questionService.ask(
            OrganizationNameQuestion(
                kitName: kitName
            ),
            predefinedAnswer: arguments.organizationNameArgument
        )
        // 7. Initialize OrganizationIdentifier
        let organizationIdentifier = self.questionService.ask(
            OrganizationIdentifierQuestion(
                organizationName: organizationName,
                kitName: kitName
            ),
            predefinedAnswer: arguments.organizationIdentifierArgument
        )
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
    // swiftlint:enable function_body_length
    
}

// MARK: - Check for CocoaPod

extension DefaultKitService {
    
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

extension DefaultKitService {
    
    /// Print Summary
    ///
    /// - Parameters:
    ///   - kit: The Kit
    ///   - directory: The Kit Directory
    func printSummary(for kit: Kit, at directory: Kit.Directory) {
        self.executable.print("\(kit.name) Summary:")
        self.executable.print(.dividerLine)
        self.executable.print("💾  Destination: \(directory.path)")
        self.executable.print("📦  Kit Name: \(kit.name)")
        self.executable.print("👨‍💻  Author: \(kit.author.name)")
        if !kit.author.email.isEmpty {
            self.executable.print("📫  E-Mail: \(kit.author.email)")
        }
        if !kit.repositoryURL.isEmpty {
            self.executable.print("🌎  Repository URL: \(kit.repositoryURL)")
        }
        self.executable.print("🏢  Organization: \(kit.organization.name)")
        self.executable.print("🖋   Organization Identifier: \(kit.organization.identifier)")
        if let ciService = kit.ciService {
            self.executable.print("🛠   CI-Service: \(ciService.displayName)")
        }
        self.executable.print(.dividerLine)
        self.executable.print("")
    }
    
    /// Print Warnings if needed
    ///
    /// - Parameter kit: The Kit
    func printWarningsIfNeeded(for kit: Kit) {
        if let isPodAvailable = self.isPodAvailable, isPodAvailable {
            self.executable.print("Warnings:")
            self.executable.print("⚠️   CocoaPods: Pod with name \"\(kit.name)\" is already taken")
            self.executable.print("")
        }
    }
    
    /// Print Start
    ///
    /// - Parameter kit: The Kit
    func printStart(with kit: Kit) {
        // Start loading on Executable
        self.executable.startLoading(
            message: "Generating \(kit.name)"
        )
    }
    
    /// Print Finish
    ///
    /// - Parameter kit: The Kit
    func printFinish(with kit: Kit) {
        // Stop loading on Executable
        self.executable.stopLoading(
            message: "\(kit.name) is ready to go 🚀"
        )
    }
    
    /// Print Error
    ///
    /// - Parameter error: The Error that should be printed
    func print(error: Error) {
        // Stop loading on Executable
        self.executable.stopLoading()
        // Print Error
        self.executable.printError(error.localizedDescription)
    }
    
}
