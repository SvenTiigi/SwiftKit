//
//  DefaultReleaseService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 07.08.19.
//

import Foundation
import PathKit

// MARK: - DefaultReleaseService

/// The DefaultReleaseService
struct DefaultReleaseService {
    
    /// The Executable
    let executable: Executable
    
    /// The Kit Directory
    let kitDirectory: Kit.Directory
    
    /// The QuestionService
    let questionService: QuestionService
    
}

// MARK: - ReleaseService

extension DefaultReleaseService: ReleaseService {
    
    /// Release a new Version of a Kit
    ///
    /// - Parameters:
    ///   - directory: The optional Directory
    ///   - version: The optional Version
    func release(in directory: String?, version: String?) {
        // Initialize mutable Kit Directory
        var kitDirectory = self.kitDirectory
        // Check if a custom Directory is available
        if let directory = directory {
            // Re-Initialize Kit Directory with Path
            kitDirectory = .init(path: directory)
        }
        // Verify Fastfile is available
        guard self.isFastfileAvailable(in: kitDirectory) else {
            // Otherwise print Error
            self.executable.printError(SwiftKitError(
                reason: "Fastfile is not available"
            ))
            // Return out of function
            return
        }
        // Ask for Version if it is not available
        let version = version ?? self.questionService.ask(VersionQuestion())
        do {
            // Start Loading
            self.executable.startLoading(message: "Start releasing version: \(version) 🚀")
            // Execute fastlane release command
            try self.executable.execute("fastlane release version:\(version)")
            // Stop loading
            self.executable.stopLoading(message: "Successfully released version: \(version) ✅")
        } catch {
            // Print Error
            self.executable.printError(error)
        }
    }
    
}

// MARK: - isFastfile available

extension DefaultReleaseService {
    
    /// Retrieve Bool value if a Fastfile in a given Directory is available
    ///
    /// - Parameter directory: The Kit Directory to search for
    /// - Returns: Bool value if Fastfile is available
    func isFastfileAvailable(in directory: Kit.Directory) -> Bool {
        // Initialize Path
        let path = PathKit.Path(directory.path.rawValue)
        // Verify recursive childrens are available
        guard let children = try? path.recursiveChildren() else {
            // Otherwise return false
            return false
        }
        // Return Bool value where children contains Fastfile
        return children.contains(where: { $0.lastComponent.lowercased() == "fastfile" })
    }
    
}

// MARK: - VersionQuestion

extension DefaultReleaseService {
    
    /// The VerisonQuestion
    struct VersionQuestion: Question {
        
        /// The QuestionVariant
        var questionVariant: QuestionVariant {
            return .required(
                text: "Please enter the version of your new release (e.g. 1.0.0)"
            )
        }
        
    }
    
}
