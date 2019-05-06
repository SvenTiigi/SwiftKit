//
//  GitBranch.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation

// MARK: - GitBranch

/// The GitBranch
enum GitBranch: Equatable, Hashable {
    /// Master Branch
    case master
    /// Develop Branch
    case develop
    /// Feature Branch
    case feature(name: String)
    /// HotFix Branch
    case hotfix(name: String)
    /// Custom Branch
    case custom(name: String)
}

// MARK: - Name

extension GitBranch {
    
    /// The Name
    var name: String {
        switch self {
        case .master:
            return "master"
        case .develop:
            return "develop"
        case .feature(let name):
            return "feature/\(name)"
        case .hotfix(let name):
            return "hotfix/\(name)"
        case .custom(let customName):
            return customName
        }
    }
    
}
