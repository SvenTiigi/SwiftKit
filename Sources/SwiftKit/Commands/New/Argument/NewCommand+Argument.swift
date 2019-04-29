//
//  NewCommand+Argument.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 29.04.19.
//

import Foundation
import SwiftCLI

// MARK: - Argument

extension NewCommand {
    
    /// The Argument
    enum Argument {
        
        /// The destination Argument
        static let destination = Key<String>(
            "-d", "--destination",
            description: "Where the generated Kit should be saved 💾"
        )
        
        /// The project name Argument
        static let projectName = Key<String>(
            "-p", "--project",
            description: "The project name of your Kit 🐣"
        )
        
        /// The author name Argument
        static let authorName = Key<String>(
            "-n", "--name",
            description: "Your name 👨‍💻"
        )
        
        /// The author email Argument
        static let authorEmail = Key<String>(
            "-e", "--email",
            description: "Your email address 📫"
        )
        
        /// The repository URL Argument
        static let repositoryURL = Key<String>(
            "-u", "--url",
            description: "The repository url 🌎"
        )
        
        /// The organization name Argument
        static let organizationName = Key<String>(
            "-o", "--organization",
            description: "The name of your organization 🏢"
        )
        
        /// The organization identifier Argument
        static let organizationIdentifier = Key<String>(
            "-i", "--organization-identifier",
            description: "The organization identifier ℹ️"
        )
        
        /// The force Argument
        static let force = Flag(
            "-f", "--force",
            description: "Generate the Kit without confirmation ✅"
        )
        
        /// The open project Argument
        static let openProject = Flag(
            "-o", "--open",
            description: "Open the Xcode project after your Kit has been generated 📂"
        )
        
    }
    
}
