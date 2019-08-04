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
    
    /// The CocoaPodsService
    let cocoaPodsService: CocoaPodsService
    
    /// The ReadableKitCreationEnvironmentConfigService
    let kitCreationEnvironmentConfigService: ReadableKitCreationEnvironmentConfigService
    
    /// The KitCreationService
    let kitCreationService: KitCreationService
    
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
    ///   - cocoaPodsService: The CocoaPodsService
    ///   - kitCreationEnvironmentConfigService: The ReadableKitCreationEnvironmentConfigService
    ///   - kitCreationService: The KitCreationService
    ///   - kitSetupService: The KitSetupService
    ///   - kitMigrationService: The KitMigrationService
    ///   - fileService: The FileService
    ///   - questionService: The QuestionService
    ///   - updateNotificationService: The UpdateNotificationService
    init(kitDirectory: Kit.Directory,
         executable: Executable,
         cocoaPodsService: CocoaPodsService,
         kitCreationEnvironmentConfigService: ReadableKitCreationEnvironmentConfigService,
         kitCreationService: KitCreationService,
         kitSetupService: KitSetupService,
         kitMigrationService: KitMigrationService,
         fileService: FileService,
         questionService: QuestionService,
         updateNotificationService: UpdateNotificationService) {
        self.kitDirectory = kitDirectory
        self.executable = executable
        self.cocoaPodsService = cocoaPodsService
        self.kitCreationEnvironmentConfigService = kitCreationEnvironmentConfigService
        self.kitCreationService = kitCreationService
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
        // Retrieve UpdateNotification
        self.updateNotificationService.getUpdateNotification { [weak self] updateNotification in
            // Set UpdateNotification
            self?.updateNotification = updateNotification
        }
        // Initialize mutable KitCreationArguments
        var arguments = arguments
        // Check if a KitCreationEnvironmentConfig is available
        if let environmentConfig = try? self.kitCreationEnvironmentConfigService.get() {
            // Re-Initialize arguments by migrating it with the KitCreationEnvironmentConfig
            arguments = environmentConfig.migrate(arguments)
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
        // Create Kit with Argument in Kit Directory
        let kit = self.kitCreationService.createKit(
            with: arguments,
            in: self.kitDirectory,
            kitNameCompletion: { [weak self] kitName in
                // Check if a Pod with the given KitName is available
                self?.cocoaPodsService.isPodAvailable(forName: kitName) { [weak self] isPodAvailable in
                    // Set isPodAvailable
                    self?.isPodAvailable = isPodAvailable
                }
            }
        )
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
