//
//  CIService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - CIService

extension Kit {
    
    /// The CIService
    enum CIService: String, Codable, Equatable, Hashable, CaseIterable {
        /// Travis CI - macOS only
        case travis = "1"
        /// Travis CI - macOS & Linux
        case travisLinux = "2"
        /// GitLab CI
        case gitlab = "3"
        /// Azure Pipelines
        case azure = "4"
        /// GitHub CI
        case github = "5"
    }
    
}

// MARK: - Properties

extension Kit.CIService {
    
    /// The DisplayName
    var displayName: String {
        switch self {
        case .travis:
            return "Travis CI - macOS only"
        case .travisLinux:
            return "Travis CI - macOS & Linux"
        case .gitlab:
            return "GitLab CI"
        case .azure:
            return "Azure Pipelines"
        case .github:
            return "GitHub CI"
        }
    }
    
    /// The source directory
    var sourceDirectory: String? {
        switch self {
        case .github:
            return ".github/workflows/"
        case .travis, .travisLinux, .gitlab, .azure:
            return nil
        }
    }
    
    /// The source file name
    var sourceFileName: String {
        switch self {
        case .travis:
            return ".travis.yml"
        case .travisLinux:
            return ".travis.linux.yml"
        case .gitlab:
            return ".gitlab-ci.yml"
        case .azure:
            return "azure-pipelines.yml"
        case .github:
            return "main.yml"
        }
    }
    
    /// The target file name
    var targetFileName: String? {
        switch self {
        case .travis, .travisLinux:
            return ".travis.yml"
        case .gitlab, .azure, .github:
            return nil
        }
    }
    
}
