//
//  ProjectNameQuestion.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - ProjectNameQuestion

/// The ProjectNameQuestion
struct ProjectNameQuestion {
    
    /// The Project Directory
    let projectDirectory: ProjectDirectory
    
    /// The FolderName
    var folderName: String? {
        return self.projectDirectory.path
            .drop(suffix: "/")
            .components(separatedBy: "/")
            .last
    }
    
}

// MARK: - Question

extension ProjectNameQuestion: Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant {
        // Initialize Question Text
        let text = "🐣  What is the name of your project?"
        // Check if FolderName is available
        if let folderName = self.folderName {
            // Return optional variant as we can provide a default answer
            return .optional(
                text: text,
                hint: "Leave empty to use: \(folderName)",
                defaultAnswer: folderName
            )
        } else {
            // Return required variant
            return .required(
                text: text
            )
        }
    }
    
}
