// swift-tools-version:4.0

import PackageDescription

/// The SwiftKit Package
let package = Package(
    name: "SwiftKit",
    products: [
        // The swiftkit executable
        .executable(
            name: "swiftkit",
            targets: ["SwiftKitCLI"]
        ),
        /// The SwiftKit Framework
        .library(
            name: "SwiftKit",
            targets: ["SwiftKit"]
        )
    ],
    dependencies: [
        // SwiftCLI Dependency
        .package(url: "https://github.com/jakeheis/SwiftCLI.git", .exact("5.2.2")),
        // Motor Dependency
        .package(url: "https://github.com/flintbox/Motor.git", .exact("0.1.2"))
    ],
    targets: [
        // SwiftKit Target
        .target(
            name: "SwiftKit",
            dependencies: []
        ),
        // SwiftKitCLI Target
        .target(
            name: "SwiftKitCLI",
            dependencies: [
                "SwiftKit",
                "SwiftCLI",
                "Motor"
            ]
        ),
        // SwiftKitTests Target
        .testTarget(
            name: "SwiftKitTests",
            dependencies: [
                "SwiftKit"
            ]
        )
    ]
)
