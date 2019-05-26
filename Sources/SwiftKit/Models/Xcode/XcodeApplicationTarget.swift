//
//  XcodeApplicationTarget.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 13.05.19.
//

import Foundation

// MARK: - XcodeApplicationTarget

/// The XcodeApplicationTarget
enum XcodeApplicationTarget: Codable, Equatable, Hashable, CaseIterable {
    /// iOS
    case iOS
    /// tvOS
    case tvOS
    /// watchOS
    case watchOS
    /// macOS
    case macOS
}

// MARK: - Array+ApplicationTarget Initializer

extension Array where Element == XcodeApplicationTarget {
    
    /// The display String
    var displayString: String {
        return self.map { $0.rawValue }.joined(separator: ", ")
    }
    
    /// Initializer with optional ApplicationTarget String representation array
    /// When passing nil `.allCases` will be used to initialize the array
    ///
    /// - Parameter targets: The ApplicationTarget String representation array
    init(targets: [String]?) {
        self = targets?.compactMap(XcodeApplicationTarget.init) ?? XcodeApplicationTarget.allCases
    }
    
}

// MARK: - RawRepresentable

extension XcodeApplicationTarget: RawRepresentable {
    
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

extension XcodeApplicationTarget {
    
    /// Retrieve excluded ApplicationTargets from included ApplicationTargets
    ///
    /// - Parameter includedTargets: The included ApplicationTargets
    /// - Returns: The excluded ApplicationTargets
    static func getExcludedTargets(includedTargets: [XcodeApplicationTarget]) -> [XcodeApplicationTarget] {
        return XcodeApplicationTarget.allCases.filter { !includedTargets.contains($0) }
    }
    
}
