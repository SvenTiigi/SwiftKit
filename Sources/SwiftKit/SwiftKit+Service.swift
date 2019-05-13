//
//  SwiftKit+Service.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 06.05.19.
//

import Foundation

// MARK: - Services

public extension SwiftKit {
    
    /// The KitService
    var kitService: KitService {
        return DefaultKitService(
            kitDirectory: .default(),
            executable: self.executable,
            gitService: self.gitService,
            cocoaPodsService: self.cocoaPodsService,
            kitSetupService: self.kitSetupService,
            kitMigrationService: self.kitMigrationService,
            fileService: self.fileService,
            questionService: self.questionService,
            updateNotificationService: self.updateNotificationService,
            xcodeProjectService: self.xcodeProjectService
        )
    }
    
    /// The UpdateService
    var updateService: UpdateService {
        return DefaultUpdateService(
            packageManagerService: self.packageManagerService,
            updateCheckService: self.updateCheckService,
            currentVersion: self.version,
            executable: self.executable
        )
    }
    
}

// MARK: - Internal Services

extension SwiftKit {
    
    /// The CocoaPodsService
    var cocoaPodsService: CocoaPodsService {
        return ExecutableCocoaPodsService(
            executable: self.executable
        )
    }
    
    /// The FileService
    var fileService: FileService {
        return ExecutableFileService(
            executable: self.executable
        )
    }
    
    /// The GitService
    var gitService: GitService {
        return ExecutableGitService(
            executable: self.executable
        )
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
    
    /// The KitSetupService
    var kitSetupService: KitSetupService {
        // Switch on Environment
        switch self.environment {
        case .production:
            // Use DefaultKitSetupService with master branch
            return DefaultKitSetupService(
                gitURL: self.gitURL,
                gitBranch: .master,
                gitService: self.gitService
            )
        case .development:
            // Use DefaultKitSetupService with develop branch
            return DefaultKitSetupService(
                gitURL: self.gitURL,
                gitBranch: .develop,
                gitService: self.gitService
            )
        case .test:
            // Use DisabledKitSetupService
            return DisabledKitSetupService()
        }
    }
    
    /// The PackageManagerService
    var packageManagerService: PackageManagerService {
        return ExecutablePackageManagerService(
            executable: self.executable
        )
    }
    
    /// The UpdateCheckService
    var updateCheckService: UpdateCheckService {
        return GitUpdateCheckService(
            repositoryURL: self.url,
            gitService: self.gitService
        )
    }
    
    /// The UpdateNotificationService
    var updateNotificationService: UpdateNotificationService {
        return DispatchQueueUpdateNotificationService(
            currentVersion: self.version,
            updateCheckService: self.updateCheckService
        )
    }
    
    /// The QuestionService
    var questionService: QuestionService {
        return ExecutableQuestionService(
            executable: self.executable
        )
    }
    
    /// The XcodeProjectService
    var xcodeProjectService: XcodeProjectService {
        return DefaultXcodeProjectService()
    }
    
}
