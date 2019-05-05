//
//  ExecutableFileService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 05.05.19.
//

import Foundation

// MARK: - ExecutableFileService

/// The ExecutableFileService
struct ExecutableFileService {
    
    /// The Executable
    let executable: Executable
    
}

// MARK: - FileService

extension ExecutableFileService: FileService {
    
    /// Open File at Path
    ///
    /// - Parameter path: The Path
    /// - Returns: If opening succeeded
    @discardableResult
    func open(atPath path: String) -> Bool {
        return (try? self.executable.execute("open \(path)")) != nil
    }
    
}
