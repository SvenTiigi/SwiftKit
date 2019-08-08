//
//  ReleaseCommand.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 07.08.19.
//

import Foundation
import SwiftCLI
import SwiftKit

// MARK: - ReleaseCommand

/// The ReleaseCommand
final class ReleaseCommand {
    
    // MARK: Propreties
    
    /// The ReleaseServive
    let releaseService: ReleaseService
    
    /// The destination Argument
    let destinationArgument = Key<String>(
        "-d", "--directory",
        description: "The Kit directory 🗂"
    )
    
    /// The version Argument
    let versionArgument = Key<String>(
        "-v", "--version",
        description: "The Version 🔢"
    )
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameter releaseService: The ReleaseService
    init(releaseService: ReleaseService) {
        self.releaseService = releaseService
    }
    
}

// MARK: - Command

extension ReleaseCommand: Command {
    
    /// The name
    var name: String {
        return "release"
    }
    
    /// A concise description of what this command or group is
    var shortDescription: String {
        return "Release a new Version of a Kit"
    }
    
    /// A longer description of how to use this command or group
    var longDescription: String {
        return self.shortDescription
    }
    
    /// Executes the command
    ///
    /// - Throws: CLI.Error if command cannot execute successfully
    func execute() throws {
        self.releaseService.release(
            in: self.destinationArgument.value,
            version: self.versionArgument.value
        )
    }
    
}
