//
//  TemplatePlaceholder+CIService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 29.04.19.
//

import Foundation

// MARK: - CIService

extension TemplatePlaceholder {
    
    /// The CIService
    enum CIService: String, Codable, Equatable, Hashable, CaseIterable {
        /// Travis CI
        case travis = "1"
        /// GitLab CI
        case gitlab = "2"
        
        /// The DisplayName
        var displayName: String {
            switch self {
            case .travis:
                return "Travis CI"
            case .gitlab:
                return "GitLab CI"
            }
        }
        
        /// The FileName
        var fileName: String {
            switch self {
            case .travis:
                return ".travis.yml"
            case .gitlab:
                return ".gitlab-ci.yml"
            }
        }
        
    }
    
}
