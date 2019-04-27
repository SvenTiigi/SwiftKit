//
//  TemplateCloneService.swift
//  Kit
//
//  Created by Sven Tiigi on 27.04.19.
//

import Foundation

// MARK: - TemplateCloneService

/// The TemplateCloneService
protocol TemplateCloneService {
    
    /// Clone Template
    ///
    /// - Parameter folderPath: The path to clone into
    /// - Throws: If cloning fails
    func clone(atPath folderPath: String) throws
    
}
