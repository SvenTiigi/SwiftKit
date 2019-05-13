//
//  ApplicationTarget.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 13.05.19.
//

import Foundation

// MARK: - ApplicationTarget

/// The ApplicationTarget
enum ApplicationTarget: String, Codable, Equatable, Hashable, CaseIterable {
    /// iOS
    case iOS
    /// tvOS
    case tvOS
    /// watchOS
    case watchOS
    /// macOS
    case macOS
}
