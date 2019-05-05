//
//  ExecutableCocoaPodsService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 03.05.19.
//

import Foundation

// MARK: - ExecutableCocoaPodsService

/// The ExecutableCocoaPodsService
struct ExecutableCocoaPodsService {
    
    /// The Executable
    let executable: Executable
    
}

// MARK: - CocoaPodsService

extension ExecutableCocoaPodsService: CocoaPodsService {
    
    /// Check if a Pod with a given name is available
    ///
    /// - Parameter name: The Pod name
    /// - Returns: Bool if Pod is available / already taken
    func isPodAvailable(forName name: String) -> Bool {
        return (try? self.executable.execute("pod trunk info \(name)")) != nil
    }
}
