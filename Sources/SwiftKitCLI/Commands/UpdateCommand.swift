//
//  UpdateCommand.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation
import SwiftCLI
import SwiftKit

// MARK: - UpdateCommand

/// The UpdateCommand
final class UpdateCommand {
    
    // MARK: Properties
    
    /// The UpdateService
    let updateService: UpdateService
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - updateService: The UpdateService
    init(updateService: UpdateService) {
        self.updateService = updateService
    }
    
}

// MARK: - Command

extension UpdateCommand: Command {
    
    /// The name
    var name: String {
        return "update"
    }
    
    /// A concise description of what this command or group is
    var shortDescription: String {
        return "Update SwiftKit"
    }
    
    /// A longer description of how to use this command or group
    var longDescription: String {
        return self.shortDescription
    }
    
    /// Executes the command
    ///
    /// - Throws: CLI.Error if command cannot execute successfully
    func execute() throws {
        // Update
        self.updateService.update()
    }
    
}
