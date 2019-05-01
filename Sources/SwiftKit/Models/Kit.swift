//
//  Kit.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - Kit

/// The Kit
public struct Kit: Codable, Equatable, Hashable {
    
    // MARK: Properties
    
    /// The name
    public let name: String
    
    /// The Author
    public let author: Author
    
    /// The repository URL
    public let repositoryURL: String
    
    /// THe Organization
    public let organization: Organization
    
    /// The optional CIService
    public let ciService: CIService?
    
    /// The date
    public let date: Date
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - name: The Kit name
    ///   - author: The Author
    ///   - repositoryURL: The repository URL
    ///   - organization: The Organization
    ///   - ciService: The optional CIService
    ///   - date: The Date. Default value `.init`
    public init(name: String,
                author: Author,
                repositoryURL: String,
                organization: Organization,
                ciService: CIService?,
                date: Date = .init()) {
        self.name = name
        self.author = author
        self.repositoryURL = repositoryURL
        self.organization = organization
        self.ciService = ciService
        self.date = date
    }
    
}

// MARK: - Placeholders

extension Kit {
    
    /// The Placeholders typealias represents a Dictionary<String, String>
    typealias Placeholders = [String: String]
    
    /// The Placeholders
    var placeholders: Placeholders {
        return [
            "KITPROJECT": self.name,
            "KITAUTHOR": self.author.name,
            "KITAUTHORMAIL": self.author.email,
            "KITURL": self.repositoryURL,
            "KITORGANIZATION": self.organization.name,
            "KITBUNDLEIDENTIFIER": self.organization.identifier,
            "KITDATE": DateFormatter.localizedString(
                from: .init(),
                dateStyle: .medium,
                timeStyle: .none
            ),
            "KITYEAR": DateFormatter(
                dateFormat: "yyyy"
            ).string(from: .init())
        ]
    }
    
}
