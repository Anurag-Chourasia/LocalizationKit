// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "LocalizationKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "LocalizationKit",
            targets: ["LocalizationKit"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/Anurag-Chourasia/FoundationKit.git",
            from: "0.1.0"
        )
    ],
    targets: [
        .target(
            name: "LocalizationKit",
            dependencies: [
                .product(name: "FoundationKit", package: "FoundationKit")
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "LocalizationKitTests",
            dependencies: ["LocalizationKit"]
        )
    ]
)
