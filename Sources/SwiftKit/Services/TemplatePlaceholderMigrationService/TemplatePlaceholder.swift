//
//  TemplatePlaceholder.swift
//  Kit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - TemplatePlaceholder

/// The TemplatePlaceholder
struct TemplatePlaceholder: Codable, Equatable, Hashable {
    
    /// The Project Name
    let projectName: String
    
    /// The Author Name
    let authorName: String
    
    /// The Author E-Mail
    let authorEmail: String
    
    /// The repository URL
    let repositoryURL: String
    
    /// The optional Organization name
    let organizationName: String
    
    /// The Bundle-Identifier
    let bundleIdentifier: String
    
    /// The Date
    var date: String {
        return DateFormatter.localizedString(
            from: Date(),
            dateStyle: DateFormatter.Style.medium,
            timeStyle: DateFormatter.Style.none
        )
    }
    
    /// The Year
    var year: String {
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        return yearFormatter.string(from: Date())
    }
    
}

// MARK: - Initializer

extension TemplatePlaceholder {
    
    init(projectName: String,
         authorName: String,
         authorEmail: String?,
         repositoryURL: String?,
         organizationName: String?,
         bundleIdentifier: String?) {
        self.projectName = projectName
        self.authorName = authorName
        self.authorEmail = authorEmail ?? ""
        self.repositoryURL = repositoryURL ?? ""
        self.organizationName = organizationName ?? projectName
        self.bundleIdentifier = bundleIdentifier ?? "com.\(projectName)"
    }
    
    
}

// MARK: - TemplatePlaceholder+KeyValuePairs

extension TemplatePlaceholder {
    
    /// The KeyValuePairs
    var keyValuePairs: [String: String] {
        return [
            "KITPROJECT": self.projectName,
            "KITAUTHOR": self.authorName,
            "KITAUTHORMAIL": self.authorEmail,
            "KITURL": self.repositoryURL,
            "KITORGANIZATION": self.organizationName,
            "KITBUNDLEIDENTIFIER": self.bundleIdentifier,
            "KITDATE": self.date,
            "KITYEAR": self.year,
        ]
    }
    
}
