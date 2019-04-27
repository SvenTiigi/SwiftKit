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
            dependencies: []
        ),
        .testTarget(
            name: "KITPROJECTTests",
            dependencies: ["KITPROJECT"]
        ),
    ]
)
