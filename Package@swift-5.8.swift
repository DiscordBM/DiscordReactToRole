// swift-tools-version: 5.8

import PackageDescription

let upcomingFeatureFlags: [SwiftSetting] = [
    /// `-enable-upcoming-feature` flags will get removed in the future
    /// and we'll need to remove them from here too.

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0335-existential-any.md
    /// Require `any` for existential types.
        .enableUpcomingFeature("ExistentialAny"),

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0274-magic-file.md
    /// Nicer `#file`.
        .enableUpcomingFeature("ConciseMagicFile"),

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0286-forward-scan-trailing-closures.md
    /// This one shouldn't do much to be honest, but shouldn't hurt as well.
        .enableUpcomingFeature("ForwardTrailingClosures"),

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0354-regex-literals.md
    /// `BareSlashRegexLiterals` not enabled since we don't use regex anywhere.

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0384-importing-forward-declared-objc-interfaces-and-protocols.md
    /// `ImportObjcForwardDeclarations` not enabled because it's objc-related.
]

let swiftSettings: [SwiftSetting] = [
    /// `DiscordBM` passes the `complete` level.
    ///
    /// `minimal` / `targeted` / `complete`
    //    .unsafeFlags(["-Xfrontend", "-strict-concurrency=complete"])
] + upcomingFeatureFlags

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
        .package(url: "https://github.com/DiscordBM/DiscordBM.git", from: "1.0.0-beta.62"),
    ],
    targets: [
        .target(
            name: "DiscordReactToRole",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "DiscordGateway", package: "DiscordBM"),
                .product(name: "DiscordHTTP", package: "DiscordBM"),
                .product(name: "DiscordModels", package: "DiscordBM"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "DiscordReactToRoleTests",
            dependencies: ["DiscordReactToRole"],
            swiftSettings: swiftSettings
        ),
    ]
)
