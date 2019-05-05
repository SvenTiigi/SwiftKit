//
//  GeneratedKit.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 03.05.19.
//

import Foundation
import SwiftKit

// MARK: - GeneratedKit

/// The GeneratedKit
struct GeneratedKit: Codable, Equatable, Hashable {
    
    /// The Kit
    let kit: Kit
    
    /// The Kit Directory
    let directory: Kit.Directory
    
}

// MARK: - ProjectPath

extension GeneratedKit {
    
    /// The Project Path
    var projectPath: String {
        return "\(self.directory.path)/\(self.kit.name).xcodeproj"
    }
    
}
