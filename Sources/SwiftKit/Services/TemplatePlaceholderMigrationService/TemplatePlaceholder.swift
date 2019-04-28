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
    
    /// The Organization name
    let organizationName: String
    
    /// The Organization Identifier
    let organizationIdentifier: String
    
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
            "KITBUNDLEIDENTIFIER": self.organizationIdentifier,
            "KITDATE": self.date,
            "KITYEAR": self.year,
        ]
    }
    
}
