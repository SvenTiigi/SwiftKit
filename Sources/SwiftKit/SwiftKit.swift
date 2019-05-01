//
//  SwiftKit.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - SwiftKit

/// The SwiftKit
public struct SwiftKit {
    
    // MARK: Properties
    
    /// The SwiftKit URL. Default value `https://github.com/SvenTiigi/SwiftKit`
    public private(set) static var url: String = "https://github.com/SvenTiigi/SwiftKit"
    
    /// The Git URL
    public static var gitURL: String {
        return self.url + ".git"
    }
    
    /// The Environment
    public let environment: Environment
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - url: The optional SwiftKit URL override.
    ///   - environment: The Environment. Default value `production`
    public init(url: String? = nil,
                environment: Environment = .production) {
        // Check if a new URL is supplied
        if let url = url {
            // Set URL
            SwiftKit.url = url
        }
        // Set Environment
        self.environment = environment
    }
    
}

// MARK: - Services

public extension SwiftKit {

    /// The GitService
    var gitService: GitService {
        return SwiftCLIGitService()
    }
    
    /// The KitService
    var kitService: KitService {
        return DefaultKitService(
            kitSetupService: self.kitSetupService,
            kitMigrationService: self.kitMigrationService
        )
    }
    
    /// The UpdateCheckService
    var updateCheckService: UpdateCheckService {
        return GitUpdateCheckService(
            repositoryURL: SwiftKit.url,
            gitService: self.gitService
        )
    }
    
}

// MARK: - Internal Services

extension SwiftKit {
    
    /// The KitSetupService
    var kitSetupService: KitSetupService {
        // Switch on Environment
        switch self.environment {
        case .production:
            // Use DefaultKitSetupService with master branch
            return DefaultKitSetupService(
                gitURL: SwiftKit.gitURL,
                gitBranch: .master,
                gitService: self.gitService
            )
        case .development:
            // Use DefaultKitSetupService with develop branch
            return DefaultKitSetupService(
                gitURL: SwiftKit.gitURL,
                gitBranch: .develop,
                gitService: self.gitService
            )
        case .test:
            // Use DisabledKitSetupService
            return DisabledKitSetupService()
        }
    }
    
    /// The KitMigrationService
    var kitMigrationService: KitMigrationService {
        // Switch on Environment
        switch self.environment {
        case .production, .development:
            // Use DefaultKitMigrationService
            return DefaultKitMigrationService()
        case .test:
            // Use DisabledKitMigrationService
            return DisabledKitMigrationService()
        }
    }
    
}
