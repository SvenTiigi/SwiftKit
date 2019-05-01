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
    
    /// The Environment
    public let environment: Environment
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameter environment: The Environment. Default value `production`
    public init(environment: Environment = .production) {
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
    
}

// MARK: - Internal Services

extension SwiftKit {
    
    /// The KitSetupService
    var kitSetupService: KitSetupService {
        // Switch on Environment
        switch self.environment {
        case .production:
            return DefaultKitSetupService(
                gitBranch: .master,
                gitService: self.gitService
            )
        case .development:
            return DefaultKitSetupService(
                gitBranch: .develop,
                gitService: self.gitService
            )
        case .test:
            return DisabledKitSetupService()
        }
    }
    
    /// The KitMigrationService
    var kitMigrationService: KitMigrationService {
        // Switch on Environment
        switch self.environment {
        case .production, .development:
            return DefaultKitMigrationService()
        case .test:
            return DisabledKitMigrationService()
        }
    }
    
}
