//
//  GenerateKitDialogService.swift
//  SwiftKitCLI
//
//  Created by Sven Tiigi on 03.05.19.
//

import Foundation
import SwiftKit

// MARK: - KitDialogService

/// The KitDialogService
protocol GenerateKitDialogService {

    /// Start genertate Kit dialog
    ///
    /// - Parameter command: The NewCommand
    /// - Returns: A Result
    func start(on command: NewCommand) -> Result<GeneratedKit, Error>

}
