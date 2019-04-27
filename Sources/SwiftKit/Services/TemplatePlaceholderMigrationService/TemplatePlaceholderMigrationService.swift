//
//  TemplatePlaceholderMigrationService.swift
//  Kit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - TemplatePlaceholderMigrationService

/// The TemplatePlaceholderMigrationService
protocol TemplatePlaceholderMigrationService {
    
    /// Migrate TemplatePlaceholder
    ///
    /// - Parameters:
    ///   - atPath: The Path
    ///   - placeholder: The TemplatePlaceholder
    func migrate(atPath folderPath: String, placeholder: TemplatePlaceholder)
    
}
