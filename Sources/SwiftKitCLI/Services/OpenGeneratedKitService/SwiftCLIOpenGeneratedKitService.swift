//
//  SwiftCLIOpenGeneratedKitService.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 03.05.19.
//

import Foundation
import SwiftCLI
import SwiftKit

// MARK: - SwiftCLIOpenGeneratedKitService

/// The SwiftCLIOpenGeneratedKitService
struct SwiftCLIOpenGeneratedKitService {}

// MARK: - OpenGeneratedKitService

extension SwiftCLIOpenGeneratedKitService: OpenGeneratedKitService {
    
    /// Open generated Kit
    ///
    /// - Parameters:
    ///   - generatedKit: The GeneratedKit
    func open(_ generatedKit: GeneratedKit) {
        try? SwiftCLI.run(bash: "open \(generatedKit.directory.path)/\(generatedKit.kit.name).xcodeproj")
    }
    
}
