//
//  SwiftCLICocoaPodsService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 03.05.19.
//

import Foundation
import SwiftCLI

// MARK: - SwiftCLICocoaPodsService

/// The SwiftCLICocoaPodsService
struct SwiftCLICocoaPodsService {}

// MARK: - CocoaPodsService

extension SwiftCLICocoaPodsService: CocoaPodsService {
    
    /// Check if a Pod with a given name is available
    ///
    /// - Parameter name: The Pod name
    /// - Returns: Bool if Pod is available / already taken
    func isPodAvailable(forName name: String) -> Bool {
        return (try? SwiftCLI.capture(bash: "pod trunk info \(name)").stdout) != nil
    }
}
