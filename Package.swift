// swift-tools-version: 5.7

import PackageDescription

#if swift(>=5.8)
let upcomingFeatureFlags: [SwiftSetting] = [
    /// `-enable-upcoming-feature` flags will get removed in the future
    /// and we'll need to remove them from here too.

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0335-existential-any.md
    /// Require `any` for existential types.
        .unsafeFlags(["-enable-upcoming-feature", "ExistentialAny"]),

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0274-magic-file.md
    /// Nicer `#file`.
        .unsafeFlags(["-enable-upcoming-feature", "ConciseMagicFile"]),

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0286-forward-scan-trailing-closures.md
    /// This one shouldn't do much to be honest, but shouldn't hurt as well.
        .unsafeFlags(["-enable-upcoming-feature", "ForwardTrailingClosures"]),

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0354-regex-literals.md
    /// `BareSlashRegexLiterals` not enabled since we don't use regex anywhere.

    /// https://github.com/apple/swift-evolution/blob/main/proposals/0384-importing-forward-declared-objc-interfaces-and-protocols.md
    /// `ImportObjcForwardDeclarations` not enabled because it's objc-related.
]
#else
/// Unsupported
let upcomingFeatureFlags: [SwiftSetting] = []
#endif

let _swiftSettings: [SwiftSetting] = [
    /// `DiscordBM` passes the `complete` level.
    ///
    /// `minimal` / `targeted` / `complete`
    .unsafeFlags(["-Xfrontend", "-strict-concurrency=complete"])
] + upcomingFeatureFlags

let enableSwiftSettings = false

/// Versioned releases can't use these flags?! So can't commit this to git while enabled.
let swiftSettings = enableSwiftSettings ? _swiftSettings : []

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
