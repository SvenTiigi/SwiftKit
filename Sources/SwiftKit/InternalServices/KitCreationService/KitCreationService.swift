//
//  KitCreationService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 04.08.19.
//

import Foundation

// MARK: - KitCreationService

/// The KitCreationService
protocol KitCreationService {
    
    /// Create Kit with KitCreationArguments in Kit Directory
    ///
    /// - Parameters:
    ///   - arguments: The KitCreationArguments
    ///   - kitDirectory: The Kit Directory
    ///   - kitNameCompletion: The Kit name completion closure
    /// - Returns: The created Kit
    func createKit(with arguments: KitCreationArguments,
                   in kitDirectory: Kit.Directory,
                   kitNameCompletion: @escaping (String) -> Void) -> Kit
    
}
