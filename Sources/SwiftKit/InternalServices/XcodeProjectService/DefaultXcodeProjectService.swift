//
//  DefaultXcodeProjectService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 13.05.19.
//

import Foundation
import PathKit
import xcodeproj

// MARK: - DefaultXcodeProjectService

/// The DefaultXcodeProjectService
struct DefaultXcodeProjectService {
    
    /// The Executable
    let executable: Executable
    
}

// MARK: - ServiceError

extension DefaultXcodeProjectService {
    
    /// The ServiceError
    enum ServiceError: Error {
        /// XcodeProject at path not found
        case xcodeProjectNotFound(path: String)
    }
    
}

// MARK: - XcodeProjectService

extension DefaultXcodeProjectService: XcodeProjectService {
    
    /// Remove ApplicationTargets from Xcode-Project in Kit Directory
    ///
    /// - Parameters:
    ///   - targets: The XcodeApplicationTargets that should be removed
    ///   - directory: The Kit Directory
    /// - Throws: If removing ApplicationTargets fails
    func remove(targets: [XcodeApplicationTarget], in directory: Kit.Directory) throws {
        // Try to initialize XcodeProject
        let xcodeProject = try XcodeProj(directory: directory)
        // For each ApplicationTarget
        for target in targets {
            // Remove Target
            xcodeProject.remove(target: target)
        }
        // Check if iOS is contained in Targets
        if targets.contains(.iOS) {
            // Remove iOS Example Target
            _ = try? xcodeProject.removeExampleTarget(
                executable: self.executable,
                directory: directory
            )
        }
        // Try to save changes to XcodeProject
        try xcodeProject.write(directory: directory)
    }
    
    /// Remove FileReferences from Xcode-Project in Kit Directory
    ///
    /// - Parameters:
    ///   - fileReferences: The Xcode FileReferences
    ///   - directory: The Kit Directory
    /// - Throws: If removing FileReferences fails
    func remove(fileReferences: [XcodeFileReference], in directory: Kit.Directory) throws {
        // Try to initialize XcodeProject
        let xcodeProject = try XcodeProj(directory: directory)
        // For each FileReference
        for fileReference in fileReferences {
            // Verify FileReference is available in XcodeProject
            guard let fileReference = xcodeProject.pbxproj.fileReferences
                .first(where: { $0.path == fileReference.name }) else {
                    // Continue with next element
                    continue
            }
            // Delete FileReference
            xcodeProject.pbxproj.delete(object: fileReference)
        }
        // Try to save changes to XcodeProject
        try xcodeProject.write(directory: directory)
    }
    
}

// MARK: - XcodeProj+RemoveTarget

private extension XcodeProj {
    
    /// Convenience Initializer with Kit Directory
    ///
    /// - Parameter directory: The Kit Directory
    /// - Throws: If XcodeProj can not be initialized
    convenience init(directory: Kit.Directory) throws {
        // Try to initialize XcodeProject
        try self.init(path: .xcodeProject(in: directory))
    }
    
    /// Write XcodeProject in Directory
    ///
    /// - Parameter directory: The Kit Directory
    /// - Throws: If writing fails
    func write(directory: Kit.Directory) throws {
        // Try to save changes to XcodeProject
        try self.write(path: .xcodeProject(in: directory), override: true)
    }
    
    /// Remove ApplicationTarget
    ///
    /// - Parameter target: The XcodeApplicationTarget that should be removed
    func remove(target: XcodeApplicationTarget) {
        // Remove Target by ApplicationTarget raw value as native Target name
        self.remove(nativeTargetName: target.rawValue)
    }
    
    /// Remove NativeTarget by name
    ///
    /// - Parameter nativeTargetName: The NativeTarget name
    func remove(nativeTargetName: String) {
        // Verify a native target which contains the ApplicationTarget raw value is available
        guard let nativeTarget = self.pbxproj.nativeTargets.first(where: { $0.name.contains(nativeTargetName) }) else {
            // Native Target is unavailable
            return
        }
        // Delete native target
        self.pbxproj.delete(object: nativeTarget)
        // Check if Schemes are available
        if let schemes = self.sharedData?.schemes {
            // Filter out any Scheme that matches the native target name
            self.sharedData?.schemes = schemes.filter { $0.name != nativeTarget.name }
        }
        // Re-Invoke remove target to ensure to remove any additional Targets (e.g. Test-Targets)
        self.remove(nativeTargetName: nativeTargetName)
    }
    
    /// Remove Example Target
    ///
    /// - Parameters:
    ///   - executable: The Executable to delete Example folder
    ///   - directory: The Kit Directory
    /// - Throws: If removing Example Target fails
    func removeExampleTarget(executable: Executable, directory: Kit.Directory) throws {
        // Initialize Example-Target Name
        let exampleTargetName = "Example"
        // Remove Example Target
        self.remove(nativeTargetName: exampleTargetName)
        // Check if Example Group can be retrieved from Groups
        if let exampleGroup = self.pbxproj.groups.first(where: { $0.path == exampleTargetName }) {
            // Delete Example Group
            self.pbxproj.delete(object: exampleGroup)
        }
        // Try to remove Example Directory
        try executable.execute("rm -rf \(directory.path)/\(exampleTargetName)")
    }
    
}

// MARK: - PathKit.Path+XcodeProjectPath

private extension PathKit.Path {
    
    /// Retrieve XcodeProject Path in Directory
    ///
    /// - Parameter directory: The Kit Directory
    /// - Returns: The XcodeProject Path
    /// - Throws: If XcodeProject is not available
    static func xcodeProject(in directory: Kit.Directory) throws -> PathKit.Path {
        // Initialize Path from Kit Directory path
        let path = PathKit.Path(directory.path.rawValue)
        // Try to retrieve children in path
        let children = try path.children()
        // Verify XcodeProject path can be retrieved
        guard let xcodeProjectPath = children.first(where: { $0.extension == "xcodeproj" }) else {
            // Throw XcodeProject not found error
            throw DefaultXcodeProjectService
                .ServiceError
                .xcodeProjectNotFound(path: path.absolute().string)
        }
        // Return XcodeProject Path
        return xcodeProjectPath
    }
    
}
