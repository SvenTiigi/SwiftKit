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
    
    /// The JSONDecoder
    let jsonDecoder: JSONDecoder
    
    /// The JSONEncoder
    let jsonEncoder: JSONEncoder
    
    // MARK: Initializer
    
    /// Designated Initializer
    ///
    /// - Parameters:
    ///   - homeDirectoryPath: The home directory path. Default value `processInfo.environment["HOME"]`
    ///   - environmentConfigFileName: The environment config file name. Default value `.swiftkit-env.json`
    ///   - jsonDecoder: The JSONDecoder. Default value `.init`
    ///   - jsonEncoder: The JSONEncoder. Default value `.init`
    init(homeDirectoryPath: String? = ProcessInfo.processInfo.environment["HOME"],
         environmentConfigFileName: String = ".swiftkit-env.json",
         jsonDecoder: JSONDecoder = .init(),
         jsonEncoder: JSONEncoder = .init()) {
        self.homeDirectoryPath = homeDirectoryPath
        self.environmentConfigFileName = environmentConfigFileName
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
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

// MARK: - ReadableKitCreationEnvironmentConfigService

extension DefaultKitCreationEnvironmentConfigService: ReadableKitCreationEnvironmentConfigService {
    
    /// Get KitCreationEnvironmentConfig
    ///
    /// - Returns: The KitCreationEnvironmentConfig
    /// - Throws: If retrieving fails
    func get() throws -> KitCreationEnvironmentConfig {
        /// Try to make environment config file url
        let environmentConfigFileURL = try self.makeEnvironmentConfigFileURL()
        // Initialize Data from file url
        let data = try Data(contentsOf: environmentConfigFileURL)
        // Try to decode Data to KitCreationEnvironmentConfig
        return try self.jsonDecoder.decode(KitCreationEnvironmentConfig.self, from: data)
    }
    
}

// MARK: - WritableKitCreationEnvironmentConfigService

extension DefaultKitCreationEnvironmentConfigService: WritableKitCreationEnvironmentConfigService {
    
    /// Save KitCreationEnvironmentConfig
    ///
    /// - Parameter kitCreationEnvironmentConfig: The KitCreationEnvironmentConfig that should be saved
    /// - Throws: If saving fails
    func save(_ kitCreationEnvironmentConfig: KitCreationEnvironmentConfig) throws {
        /// Try to make environment config file url
        let environmentConfigFileURL = try self.makeEnvironmentConfigFileURL()
        // Try to encode KitCreationEnvironmentConfig
        let data = try self.jsonEncoder.encode(kitCreationEnvironmentConfig)
        // Try to write Data to URL
        try data.write(to: environmentConfigFileURL)
    }
    
}

// MARK: - Make Environment Config File URL

extension DefaultKitCreationEnvironmentConfigService {

    /// Make Environment Config File URL
    ///
    /// - Returns: The Environment Config File URL
    /// - Throws: If retrieving file URL fails
    func makeEnvironmentConfigFileURL() throws -> URL {
        // Verify home directory path is available
        guard let homeDirectoryPath = self.homeDirectoryPath else {
            // Throw home directory unavailable error
            throw ServiceError.homeDirectoryUnavailable
        }
        // Initialize home directory file URL
        var homeDirectoryFileURL = URL(fileURLWithPath: homeDirectoryPath)
        // Append environment config file name to url
        homeDirectoryFileURL.appendPathComponent(self.environmentConfigFileName)
        // Return home directory file URL
        return homeDirectoryFileURL
    }
    
}
