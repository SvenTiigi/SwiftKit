//
//  GitConfigKey.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation

// MARK: - GitConfigKey

/// The GitConfigKey
enum GitConfigKey: String, Codable, Equatable, Hashable, CaseIterable {
    /// The name
    case name = "user.name"
    /// The email
    case email = "user.email"
}
