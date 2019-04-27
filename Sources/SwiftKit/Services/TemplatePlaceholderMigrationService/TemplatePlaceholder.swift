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
            from: .init(),
            dateStyle: .medium,
            timeStyle: .none
        )
    }
    
    /// The Year
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: .init())
    }
    
}

// MARK: - Initializer

extension TemplatePlaceholder {
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - projectName: The project Name
    ///   - authorName: The author name
    ///   - authorEmail: The optional author E-Mail. Default value `empty`
    ///   - repositoryURL: The optional repository url. Default value `github/author/project`
    ///   - organizationName: The optional organization name. Default value `projectName`
    ///   - bundleIdentifier: The optional bundle identifier. Default value `"com.\(projectName)"`
    init(projectName: String,
         authorName: String,
         authorEmail: String?,
         repositoryURL: String?,
         organizationName: String?,
         bundleIdentifier: String?) {
        self.projectName = projectName
        self.authorName = authorName
        self.authorEmail = authorEmail ?? ""
        self.repositoryURL = repositoryURL ?? "https://github.com/\(authorName)/\(projectName)"
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
