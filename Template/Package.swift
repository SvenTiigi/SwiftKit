// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "KITPROJECT",
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
