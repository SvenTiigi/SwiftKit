// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "SwiftKit",
    products: [
        .executable(
            name: "swiftkit",
            targets: [
                "SwiftKit"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/jakeheis/SwiftCLI.git", .exact("5.2.2")),
        .package(url: "https://github.com/flintbox/Motor.git", .exact("0.1.2"))
    ],
    targets: [
        .target(
            name: "SwiftKit",
            dependencies: [
                "SwiftCLI",
                "Motor"
            ]
        ),
        .testTarget(
            name: "SwiftKitTests",
            dependencies: [
                "SwiftKit"
            ]
        ),
    ]
)
