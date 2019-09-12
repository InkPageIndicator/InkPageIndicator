// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "InkPageIndicator",
    products: [
        .library(
            name: "InkPageIndicator",
            targets: ["InkPageIndicator"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "InkPageIndicator",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "InkPageIndicatorTests",
            dependencies: ["InkPageIndicator"],
            path: "Tests"
        ),
    ]
)
