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
    ///   - targets: The XcodeApplicationTargets that should be removed
    ///   - directory: The Kit Directory
    /// - Throws: If removing ApplicationTargets fails
    func remove(targets: [XcodeApplicationTarget], in directory: Kit.Directory) throws
    
    /// Remove FileReferences from Xcode-Project in Kit Directory
    ///
    /// - Parameters:
    ///   - fileReferences: The Xcode FileReferences
    ///   - directory: The Kit Directory
    /// - Throws: If removing FileReferences fails
    func remove(fileReferences: [XcodeFileReference], in directory: Kit.Directory) throws
    
}
