//
//  SwiftKit+Services.swift
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
            cocoaPodsService: self.cocoaPodsService,
            kitCreationEnvironmentConfigService: self.kitCreationEnvironmentConfigService,
            kitCreationService: self.kitCreationService,
            kitSetupService: self.kitSetupService,
            kitMigrationService: self.kitMigrationService,
            fileService: self.fileService,
            questionService: self.questionService,
            updateNotificationService: self.updateNotificationService
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
    
    /// The ReleaseService
    var releaseService: ReleaseService {
        return DefaultReleaseService(
            executable: self.executable,
            kitDirectory: .default(),
            questionService: self.questionService
        )
    }
    
}

// MARK: - Internal Services

extension SwiftKit {
    
    /// The CocoaPodsService
    var cocoaPodsService: CocoaPodsService {
        return DispatchQueueExecutableCocoaPodsService(
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
            swiftKitURL: self.url,
            executable: self.executable
        )
    }
    
    /// The KitCreationEnvironmentConfigService
    var kitCreationEnvironmentConfigService: KitCreationEnvironmentConfigService {
        return DefaultKitCreationEnvironmentConfigService()
    }
    
    /// The KitCreationService
    var kitCreationService: KitCreationService {
        return QuestionKitCreationService(
            questionService: self.questionService,
            gitService: self.gitService
        )
    }
    
    /// The KitSetupService
    var kitSetupService: KitSetupService {
        return DefaultKitSetupService(
            gitURL: self.gitURL,
            gitBranch: self.branch,
            gitService: self.gitService
        )
    }
    
    /// The KitMigrationService
    var kitMigrationService: KitMigrationService {
        return SummarizingKitMigrationService(
            kitMigrationServices: [
                DefaultKitMigrationService(),
                CIServiceKitMigrationService(
                    xcodeProjectService: self.xcodeProjectService
                ),
                ExcludedTargetsKitMigrationService(
                    xcodeProjectService: self.xcodeProjectService
                ),
                GitSetupKitMigrationService(
                    gitService: self.gitService
                )
            ]
        )
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
        return DefaultXcodeProjectService(
            executable: self.executable
        )
    }
    
}
