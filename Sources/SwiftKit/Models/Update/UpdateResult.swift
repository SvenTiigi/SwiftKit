//
//  UpdateResult.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 08.05.19.
//

import Foundation

// MARK: - UpdateResult

/// The UpdateResult
enum UpdateResult: Equatable, Hashable {
    /// Latest version
    case latest
    /// A new version is available
    case available(version: Version)
}
