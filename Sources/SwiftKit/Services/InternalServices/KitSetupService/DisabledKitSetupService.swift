//
//  DisabledKitSetupService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 01.05.19.
//

import Foundation

// MARK: - DisabledKitSetupService

/// The DisabledKitSetupService
struct DisabledKitSetupService: KitSetupService {
    
    /// Setup Kit at Directory
    ///
    /// - Parameter kitDirectory: The Kit Directory
    /// - Throws: If setup fails
    func setup(at kitDirectory: Kit.Directory) throws {
        // Simply do nothing
        struct BlaError: Error {
            var localizedDescription: String {
                return "System Error prefix count was one was not bla"
            }
        }
        throw SwiftKitError.init(reason: "Something went wrong", error: BlaError())
    }
    
    
}
