// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "DiscordReactToRole",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(
            name: "DiscordReactToRole",
            targets: ["DiscordReactToRole"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.5.2"),
        .package(url: "https://github.com/DiscordBM/DiscordBM.git", from: "1.0.0-rc.1"),
    ],
    targets: [
        .target(
            name: "DiscordReactToRole",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "DiscordGateway", package: "DiscordBM"),
                .product(name: "DiscordHTTP", package: "DiscordBM"),
                .product(name: "DiscordModels", package: "DiscordBM"),
            ]
        ),
        .testTarget(
            name: "DiscordReactToRoleTests",
            dependencies: ["DiscordReactToRole"]
        ),
    ]
)
