//
//  NewCommand.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation
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
    let destinationArgument = Key<String>(
        "-d", "--destination",
        description: "Where the generated Kit should be saved 💾"
    )
    
    /// The Kit name Argument
    let kitNameArgument = Key<String>(
        "-k", "--kit-name",
        description: "The name of your Kit 📦"
    )
    
    /// The author name Argument
    let authorNameArgument = Key<String>(
        "-n", "--name",
        description: "Your name 👨‍💻"
    )
    
    /// The author email Argument
    let authorEmailArgument = Key<String>(
        "-e", "--email",
        description: "Your email address 📫"
    )
    
    /// The repository URL Argument
    let repositoryURLArgument = Key<String>(
        "-u", "--url",
        description: "The repository url 🌎"
    )
    
    /// The CIService Argument
    let ciServiceArgument = Key<String>(
        "-c", "--ci-service",
        description: "The CI-Service 🛠"
    )
    
    /// The organization name Argument
    let organizationNameArgument = Key<String>(
        "-o", "--organization",
        description: "The name of your organization 🏢"
    )
    
    /// The organization identifier Argument
    let organizationIdentifierArgument = Key<String>(
        "-i", "--organization-identifier",
        description: "The organization identifier ℹ️"
    )
    
    /// The force Argument
    let forceArgument = Flag(
        "-f", "--force",
        description: "Generate the Kit without confirmation ✅"
    )
    
    /// The open project Argument
    let openProjectArgument = Flag(
        "-o", "--open",
        description: "Open the Xcode project after your Kit has been generated 📂"
    )
    
    /// The variadic Target Argument
    let targetArgument = VariadicKey<String>(
        "-t", "--target",
        description: "The Target that should be included in your Kit 📱"
    )
    
    // MARK: Properties
    
    /// The KitService
    let kitService: KitService
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - kitService: The KitService
    init(kitService: KitService) {
        self.kitService = kitService
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
        // Create Kit with KitCreationArguments
        self.kitService.create(with: self.kitCreationArguments)
    }

}

// MARK: - KitArguments

extension NewCommand {
    
    /// The KitCreationArguments
    var kitCreationArguments: KitCreationArguments {
        return .init(
            kitNameParameter: self.kitNameParameter.value,
            destinationArgument: self.destinationArgument.value,
            kitNameArgument: self.kitNameArgument.value,
            authorNameArgument: self.authorNameArgument.value,
            authorEmailArgument: self.authorEmailArgument.value,
            repositoryURLArgument: self.repositoryURLArgument.value,
            ciServiceArgument: self.ciServiceArgument.value,
            organizationNameArgument: self.organizationNameArgument.value,
            organizationIdentifierArgument: self.organizationIdentifierArgument.value,
            forceArgument: self.forceArgument.value,
            openProjectArgument: self.openProjectArgument.value,
            targetsArgument: self.targetArgument.values.isEmpty ? nil : self.targetArgument.values
        )
    }
    
}
