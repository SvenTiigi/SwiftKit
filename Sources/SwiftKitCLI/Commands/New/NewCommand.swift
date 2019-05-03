//
//  NewCommand.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation
import SwiftCLI

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
    
    /// The GenerateKitDialogService
    let generateKitDialogService: GenerateKitDialogService
    
    /// The OpenGeneratedKitService
    let openGeneratedKitService: OpenGeneratedKitService
    
    /// The UpdateNotifierService
    let updateNotifierService: UpdateNotifierService
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - generateKitDialogService: The GenerateKitDialogService
    ///   - openGeneratedKitService: The OpenGeneratedKitService
    ///   - updateNotifierService: The UpdateNotifierService
    init(generateKitDialogService: GenerateKitDialogService,
         openGeneratedKitService: OpenGeneratedKitService,
         updateNotifierService: UpdateNotifierService) {
        self.generateKitDialogService = generateKitDialogService
        self.openGeneratedKitService = openGeneratedKitService
        self.updateNotifierService = updateNotifierService
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
        // Print out Ascii Art
        stdout <<< .asciiArt
        // Start GenerateKitDialogService and verify generated Kit is available
        guard case .success(let generatedKit) = self.generateKitDialogService.start(on: self) else {
            // Generating Kit failed return out of function
            return
        }
        // Verify if OpenProject Argument is present
        if self.openProjectArgument.isPresent {
            // Open generated Kit
            self.openGeneratedKitService.open(generatedKit)
        }
        // Notify about updates if needed
        self.updateNotifierService.notifyIfNeeded(on: self)
    }

}
