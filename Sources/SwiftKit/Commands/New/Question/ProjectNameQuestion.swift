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
    var folderName: String {
        return self.projectDirectory.path.drop(suffix: "/").components(separatedBy: "/").last!
    }
    
}

// MARK: - Question

extension ProjectNameQuestion: Question {
    
    /// The QuestionVariant
    var questionVariant: QuestionVariant {
        return .optional(
            text: "🐣  What is the name of your project?",
            hint: "Leave empty to use: \(self.folderName)",
            defaultAnswer: self.folderName
        )
    }
    
}
