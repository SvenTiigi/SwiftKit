//
//  EmptyTemplatePlaceholderMigrationService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 28.04.19.
//

import Foundation

// MARK: - EmptyTemplatePlaceholderMigrationService

/// The EmptyTemplatePlaceholderMigrationService
struct EmptyTemplatePlaceholderMigrationService: TemplatePlaceholderMigrationService {
    
    func migrate(atPath folderPath: String, placeholder: TemplatePlaceholder) {}
    
}
