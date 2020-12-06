// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "KITPROJECT",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "KITPROJECT",
            targets: ["KITPROJECT"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "KITPROJECT",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "KITPROJECTTests",
            dependencies: ["KITPROJECT"],
            path: "Tests"
        ),
    ]
)
