//
//  KitCreationArguments.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation

// MARK: - KitCreationArguments

/// The KitCreationArguments
public struct KitCreationArguments: Codable, Equatable, Hashable {
    
    // MARK: Properties
    
    /// The Kit name parameter
    let kitNameParameter: String?
    
    /// The destination argument
    let destinationArgument: String?
    
    /// The Kit name argument
    let kitNameArgument: String?
    
    /// The author name argument
    let authorNameArgument: String?
    
    /// The author email argument
    let authorEmailArgument: String?
    
    /// The repository URL argument
    let repositoryURLArgument: String?
    
    /// The CIService argument
    let ciServiceArgument: String?
    
    /// The organization name argument
    let organizationNameArgument: String?
    
    /// The organization identifier argument
    let organizationIdentifierArgument: String?
    
    /// The force argument
    let forceArgument: Bool
    
    /// The open project argument
    let openProjectArgument: Bool
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - kitNameParameter: The Kit name parameter
    ///   - destinationArgument: The destination argument
    ///   - kitNameArgument: The Kit name argument
    ///   - authorNameArgument: The author name argument
    ///   - authorEmailArgument: The author email argument
    ///   - repositoryURLArgument: The repository URL argument
    ///   - ciServiceArgument: The CIService argument
    ///   - organizationNameArgument: The organization name argument
    ///   - organizationIdentifierArgument: The organization identifier argument
    ///   - forceArgument: The force argument
    ///   - openProjectArgument: The open project argument
    public init(kitNameParameter: String?,
                destinationArgument: String?,
                kitNameArgument: String?,
                authorNameArgument: String?,
                authorEmailArgument: String?,
                repositoryURLArgument: String?,
                ciServiceArgument: String?,
                organizationNameArgument: String?,
                organizationIdentifierArgument: String?,
                forceArgument: Bool,
                openProjectArgument: Bool) {
        self.kitNameParameter = kitNameParameter
        self.destinationArgument = destinationArgument
        self.kitNameArgument = kitNameArgument
        self.authorNameArgument = authorNameArgument
        self.authorEmailArgument = authorEmailArgument
        self.repositoryURLArgument = repositoryURLArgument
        self.ciServiceArgument = ciServiceArgument
        self.organizationNameArgument = organizationNameArgument
        self.organizationIdentifierArgument = organizationIdentifierArgument
        self.forceArgument = forceArgument
        self.openProjectArgument = openProjectArgument
    }
    
}
