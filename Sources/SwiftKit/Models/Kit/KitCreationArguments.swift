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
    
    /// The template repository URL Argument
    let templateRepositoryURLArgument: String?
    
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
    
    /// The Targets argument
    let targetsArgument: [String]?
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - kitNameParameter: The Kit name parameter
    ///   - templateRepositoryURLArgument: The template repository URL Argument
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
    ///   - targetsArgument: The Targets argument
    public init(kitNameParameter: String?,
                templateRepositoryURLArgument: String?,
                destinationArgument: String?,
                kitNameArgument: String?,
                authorNameArgument: String?,
                authorEmailArgument: String?,
                repositoryURLArgument: String?,
                ciServiceArgument: String?,
                organizationNameArgument: String?,
                organizationIdentifierArgument: String?,
                forceArgument: Bool,
                openProjectArgument: Bool,
                targetsArgument: [String]?) {
        self.kitNameParameter = kitNameParameter
        self.templateRepositoryURLArgument = templateRepositoryURLArgument
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
        self.targetsArgument = targetsArgument
    }
    
}
