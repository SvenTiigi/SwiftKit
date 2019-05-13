//
//  ApplicationTarget.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 13.05.19.
//

import Foundation

// MARK: - ApplicationTarget

/// The ApplicationTarget
enum ApplicationTarget: Codable, Equatable, Hashable, CaseIterable {
    /// iOS
    case iOS
    /// tvOS
    case tvOS
    /// watchOS
    case watchOS
    /// macOS
    case macOS
}

// MARK: - RawRepresentable Initializer

extension ApplicationTarget: RawRepresentable {
    
    /// The corresponding value of the raw type.
    var rawValue: String {
        switch self {
        case .iOS:
            return "iOS"
        case .tvOS:
            return "tvOS"
        case .watchOS:
            return "watchOS"
        case .macOS:
            return "macOS"
        }
    }
    
    /// Creates a new instance with the specified raw value.
    ///
    /// - Parameter rawValue: The raw value to use for the new instance.
    init?(rawValue: String) {
        switch rawValue.lowercased() {
        case "ios":
            self = .iOS
        case "tvos":
            self = .tvOS
        case "watchos":
            self = .watchOS
        case "macos":
            self = .macOS
        default:
            return nil
        }
    }
    
}

// MARK: - Get Excluded Targets

extension ApplicationTarget {
    
    /// Retrieve excluded ApplicationTargets from included ApplicationTarget Strings
    ///
    /// - Parameter includedTargets: The included ApplicationTarget Strings
    /// - Returns: The excluded ApplicationTargets
    static func getExcludedTargets(includedTargets: [String]) -> [ApplicationTarget] {
        let includedTargets = includedTargets.compactMap(ApplicationTarget.init)
        let excludedTargets = ApplicationTarget.allCases.filter { !includedTargets.contains($0) }
        return excludedTargets
    }
    
}
