//
//  EmptyTemplateCloneService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 28.04.19.
//

import Foundation

// MARK: - EmptyTemplateCloneService

/// The EmptyTemplateCloneService
struct EmptyTemplateCloneService: TemplateCloneService {
    
    func clone(atPath folderPath: String) throws {}
    
}
