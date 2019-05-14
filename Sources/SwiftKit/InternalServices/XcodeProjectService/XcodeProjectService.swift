//
//  XcodeProjectService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 13.05.19.
//

import Foundation

// MARK: - XcodeProjectService

/// The XcodeProjectService
protocol XcodeProjectService {
    
    /// Remove ApplicationTargets from Xcode-Project in Kit Directory
    ///
    /// - Parameters:
    ///   - targets: The ApplicationTargets that should be removed
    ///   - directory: The Kit Directory
    /// - Throws: If removing ApplicationTargets fails
    func remove(targets: [ApplicationTarget], in directory: Kit.Directory) throws
    
}
