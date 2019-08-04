//
//  QuestionKitCreationService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 04.08.19.
//

import Foundation

// MARK: - QuestionKitCreationService

/// The QuestionKitCreationService
struct QuestionKitCreationService {
    
    /// The QuestionService
    let questionService: QuestionService
    
    /// The GitService
    let gitService: GitService
    
}

// MARK: - KitCreationService

extension QuestionKitCreationService: KitCreationService {
    
    /// Create Kit with KitCreationArguments in Kit Directory
    ///
    /// - Parameters:
    ///   - arguments: The KitCreationArguments
    ///   - kitDirectory: The Kit Directory
    ///   - kitNameCompletion: The Kit name completion closure
    /// - Returns: The created Kit
    func createKit(with arguments: KitCreationArguments,
                   in kitDirectory: Kit.Directory,
                   kitNameCompletion: @escaping (String) -> Void) -> Kit {
        // 1. Initialize Kit name
        let kitName = self.questionService.ask(
            KitNameQuestion(
                kitDirectory: kitDirectory
            ),
            predefinedAnswer: arguments.kitNameParameter ?? arguments.kitNameArgument
        )
        // Invoke Kit name completion closure
        kitNameCompletion(kitName)
        // 2. Initialize AuthorName
        let authorName = self.questionService.ask(
            AuthorNameQuestion(
                gitService: self.gitService
            ),
            predefinedAnswer: arguments.authorNameArgument
        )
        // 3. Initialize AuthorEmail
        let authorEmail = self.questionService.ask(
            AuthorEmailQuestion(
                gitService: self.gitService
            ),
            predefinedAnswer: arguments.authorEmailArgument
        )
        // 4. Initialize RepositoryURL
        let repositoryURL = self.questionService.ask(
            RepositoryURLQuestion(
                kitDirectory: kitDirectory,
                gitService: self.gitService,
                kitName: kitName,
                authorName: authorName
            ),
            predefinedAnswer: arguments.repositoryURLArgument
        )
        // 5. Initialize CIService
        let ciService = Kit.CIService(
            rawValue: self.questionService.ask(
                CIServiceQuestion(),
                predefinedAnswer: arguments.ciServiceArgument
            )
        )
        // 6. Initialize OrganizationName
        let organizationName = self.questionService.ask(
            OrganizationNameQuestion(
                kitName: kitName
            ),
            predefinedAnswer: arguments.organizationNameArgument
        )
        // 7. Initialize OrganizationIdentifier
        let organizationIdentifier = self.questionService.ask(
            OrganizationIdentifierQuestion(
                organizationName: organizationName,
                kitName: kitName
            ),
            predefinedAnswer: arguments.organizationIdentifierArgument
        ).dropWhitespaces()
        // Return Kit
        return .init(
            name: kitName,
            author: .init(
                name: authorName,
                email: authorEmail
            ),
            repositoryURL: repositoryURL,
            organization: .init(
                name: organizationName,
                identifier: organizationIdentifier
            ),
            ciService: ciService,
            applicationTargets: .init(
                targets: arguments.targetsArgument
            )
        )
    }
    
}
