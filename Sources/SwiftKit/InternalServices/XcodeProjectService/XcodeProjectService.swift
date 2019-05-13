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
    
    /// Remove ApplicationTarget from Xcode-Project in Kit Directory
    ///
    /// - Parameters:
    ///   - target: The ApplicationTarget that should be removed
    ///   - directory: The Kit Directory
    /// - Throws: If removing ApplicationTarget fails
    func remove(target: ApplicationTarget, in directory: Kit.Directory) throws
    
}
