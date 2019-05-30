//
//  KitCreationArguments+EnvironmentConfig.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 30.05.19.
//

import Foundation

// MARK: - KitCreationEnvironmentConfig

/// The KitCreationEnvironmentConfig
struct KitCreationEnvironmentConfig: Equatable, Hashable {
    
    /// The author name
    let authorName: String?
    
    /// The author email
    let authorEmail: String?
    
    /// The organization name
    let organizationName: String?
    
    /// The organization identifier
    let organizationIdentifier: String?
    
}

// MARK: - Codable

extension KitCreationEnvironmentConfig: Codable {
    
    /// Initializer from Decoder
    ///
    /// - Parameter decoder: The Decoder
    /// - Throws: If decoding fails
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.authorName = try container.decodeIfPresent(String.self, forKey: .authorName)
        self.authorEmail = try container.decodeIfPresent(String.self, forKey: .authorEmail)
        self.organizationName = try container.decodeIfPresent(String.self, forKey: .organizationName)
        self.organizationIdentifier = try container.decodeIfPresent(String.self, forKey: .organizationIdentifier)
    }
    
}

// MARK: - Migrate KitCreationArguments

extension KitCreationEnvironmentConfig {
    
    /// Migrate KitCreationArguments with EnvironmentConfig
    ///
    /// - Parameter arguments: The KitCreationArguments that should be migrated
    /// - Returns: The migrated KitCreationArguments
    func migrate(_ arguments: KitCreationArguments) -> KitCreationArguments {
        let authorNameArgument = arguments.authorNameArgument ?? self.authorName
        let authorEmailArgument = arguments.authorEmailArgument ?? self.authorEmail
        let organizationNameArgument = arguments.organizationNameArgument ?? self.organizationName
        let organizationIdentifierArgument = arguments.organizationIdentifierArgument ?? self.organizationIdentifier
        return .init(
            kitNameParameter: arguments.kitNameParameter,
            destinationArgument: arguments.destinationArgument,
            kitNameArgument: arguments.kitNameArgument,
            authorNameArgument: authorNameArgument,
            authorEmailArgument: authorEmailArgument,
            repositoryURLArgument: arguments.repositoryURLArgument,
            ciServiceArgument: arguments.ciServiceArgument,
            organizationNameArgument: organizationNameArgument,
            organizationIdentifierArgument: organizationIdentifierArgument,
            forceArgument: arguments.forceArgument,
            openProjectArgument: arguments.openProjectArgument,
            targetsArgument: arguments.targetsArgument
        )
    }
    
}
