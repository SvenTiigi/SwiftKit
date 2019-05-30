//
//  DefaultKitCreationEnvironmentConfigService.swift
//  SwiftKit
//
//  Created by Sven Tiigi on 30.05.19.
//

import Foundation

// MARK: - DefaultKitCreationEnvironmentConfigService

/// The DefaultKitCreationEnvironmentConfigService
struct DefaultKitCreationEnvironmentConfigService {
    
    // MARK: Properties
    
    /// The home directory path
    let homeDirectoryPath: String?
    
    /// The environment config file name
    let environmentConfigFileName: String
    
    /// The URL type
    let urlType: URL.Type
    
    /// The Data type
    let dataType: Data.Type
    
    /// The JSONDecoder
    let jsonDecoder: JSONDecoder
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - homeDirectoryPath: The home directory path. Default value `processInfo.environment["HOME"]`
    ///   - environmentConfigFileName: The environment config file name. Default value `.swiftkit-env.json`
    ///   - dataTyurlTypepe: The URL type. Default value `URL.self`
    ///   - dataType: The Data type. Default value `Data.self`
    ///   - jsonDecoder: The JSONDecoder. Default value `.init`
    init(homeDirectoryPath: String? = ProcessInfo.processInfo.environment["HOME"],
         environmentConfigFileName: String = ".swiftkit-env.json",
         urlType: URL.Type = URL.self,
         dataType: Data.Type = Data.self,
         jsonDecoder: JSONDecoder = .init()) {
        self.homeDirectoryPath = homeDirectoryPath
        self.environmentConfigFileName = environmentConfigFileName
        self.urlType = urlType
        self.dataType = dataType
        self.jsonDecoder = jsonDecoder
    }
    
}

// MARK: - ServiceError

extension DefaultKitCreationEnvironmentConfigService {
    
    /// The ServiceError
    enum ServiceError: Error {
        /// HomeDirectory is unavailable
        case homeDirectoryUnavailable
    }
    
}

// MARK: - KitCreationEnvironmentConfigService

extension DefaultKitCreationEnvironmentConfigService: KitCreationEnvironmentConfigService {
    
    /// Get KitCreationEnvironmentConfig
    ///
    /// - Returns: The KitCreationEnvironmentConfig
    /// - Throws: If retrieving fails
    func get() throws -> KitCreationEnvironmentConfig {
        // Verify home directory path is available
        guard let homeDirectoryPath = self.homeDirectoryPath else {
            // Throw home directory unavailable error
            throw ServiceError.homeDirectoryUnavailable
        }
        // Initialize home directory file URL
        var homeDirectoryFileURL = self.urlType.init(fileURLWithPath: homeDirectoryPath)
        // Append environment config file name to url
        homeDirectoryFileURL.appendPathComponent(self.environmentConfigFileName)
        // Initialize Data from file url
        let data = try self.dataType.init(contentsOf: homeDirectoryFileURL)
        // Try to decode Data to KitCreationEnvironmentConfig
        return try self.jsonDecoder.decode(KitCreationEnvironmentConfig.self, from: data)
    }
    
}
