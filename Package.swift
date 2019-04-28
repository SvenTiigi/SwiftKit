// swift-tools-version:5.0

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
        .package(url: "https://github.com/jakeheis/SwiftCLI.git", .exact("5.2.2"))
    ],
    targets: [
        .target(
            name: "SwiftKit",
            dependencies: [
                "SwiftCLI"
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
