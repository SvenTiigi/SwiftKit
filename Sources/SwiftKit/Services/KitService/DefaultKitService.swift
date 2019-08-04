//
//  DefaultKitService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

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
    
    /// The ReadableKitCreationEnvironmentConfigService
    let kitCreationEnvironmentConfigService: ReadableKitCreationEnvironmentConfigService
    
    /// The KitSetupService
    let kitSetupService: KitSetupService
    
    /// The KitMigrationService
    let kitMigrationService: KitMigrationService
    
    /// The FileService
    let fileService: FileService
    
    /// The QuestionService
    let questionService: QuestionService
    
    /// The UpdateNotificationService
    let updateNotificationService: UpdateNotificationService
    
    /// Bool if pod is available
    var isPodAvailable: Bool?
    
    /// The optional UpdateNotification
    var updateNotification: UpdateNotification?
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - kitDirectory: The Kit Directory
    ///   - executable: The Executable
    ///   - gitService: The GitService
    ///   - cocoaPodsService: The CocoaPodsService
    ///   - kitCreationEnvironmentConfigService: The ReadableKitCreationEnvironmentConfigService
    ///   - kitSetupService: The KitSetupService
    ///   - kitMigrationService: The KitMigrationService
    ///   - fileService: The FileService
    ///   - questionService: The QuestionService
    ///   - updateNotificationService: The UpdateNotificationService
    init(kitDirectory: Kit.Directory,
         executable: Executable,
         gitService: GitService,
         cocoaPodsService: CocoaPodsService,
         kitCreationEnvironmentConfigService: ReadableKitCreationEnvironmentConfigService,
         kitSetupService: KitSetupService,
         kitMigrationService: KitMigrationService,
         fileService: FileService,
         questionService: QuestionService,
         updateNotificationService: UpdateNotificationService) {
        self.kitDirectory = kitDirectory
        self.executable = executable
        self.gitService = gitService
        self.cocoaPodsService = cocoaPodsService
        self.kitCreationEnvironmentConfigService = kitCreationEnvironmentConfigService
        self.kitSetupService = kitSetupService
        self.kitMigrationService = kitMigrationService
        self.fileService = fileService
        self.questionService = questionService
        self.updateNotificationService = updateNotificationService
    }
    
}

// MARK: - KitService

extension DefaultKitService: KitService {

    /// Create Kit
    ///
    /// - Parameter arguments: The KitCreationArguments
    func create(with arguments: KitCreationArguments) {
        // Initialize mutable KitCreationArguments
        var arguments = arguments
        // Check if a KitCreationEnvironmentConfig is available
        if let environmentConfig = try? self.kitCreationEnvironmentConfigService.get() {
            // Re-Initialize arguments by migrating it with the KitCreationEnvironmentConfig
            arguments = environmentConfig.migrate(arguments)
        }
        // Retrieve UpdateNotification
        self.updateNotificationService.getUpdateNotification { [weak self] updateNotification in
            // Set UpdateNotification
            self?.updateNotification = updateNotification
        }
        // Check if the Destination Argument Value is available
        if let destinationArgumentValue = arguments.destinationArgument {
            // Set Kit Directory Path with Destination Argument Value
            self.kitDirectory.path = .init(rawValue: destinationArgumentValue)
        }
        // Check if a Kit name Parameter value is available
        if let kitName = arguments.kitNameParameter {
            // Append Kit name to Kit Directory Path
            self.kitDirectory.path.append(kitName)
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
            try self.kitSetupService.setup(
                with: arguments,
                at: self.kitDirectory
            )
            // Try to migrate Kit
            try self.kitMigrationService.migrate(
                kit: kit,
                at: self.kitDirectory
            )
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
        // Show UpdateNotification on Executable if available
        self.updateNotification?.show(on: self.executable)
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
        // Check if a Pod with the given KitName is available
        self.cocoaPodsService.isPodAvailable(forName: kitName) { [weak self] isPodAvailable in
            // Set isPodAvailable
            self?.isPodAvailable = isPodAvailable
        }
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
        ).dropWhitespaces()
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
            ciService: ciService,
            applicationTargets: .init(
                targets: arguments.targetsArgument
            )
        )
    }
    // swiftlint:enable function_body_length
    
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
        self.executable.print("💾  Destination: \(directory.path.rawValue)")
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
        self.executable.print("📱  Targets: \(kit.applicationTargets.displayString)")
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
