// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Windmill",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WindmillClient",
            targets: ["WindmillClient"]
        ),
        .library(
            name: "WindmillCodec",
            targets: ["WindmillCodec"]
        ),
        .library(
            name: "WindmillConfiguration",
            targets: ["WindmillConfiguration"]
        ),
        .library(
            name: "WindmillConsole",
            targets: ["WindmillConsole"]
        ),
        .library(
            name: "WindmillContext",
            targets: ["WindmillContext"]
        ),
        .library(
            name: "WindmillCore",
            targets: ["WindmillCore"]
        ),
        .library(
            name: "WindmillDataAccess",
            targets: ["WindmillDataAccess"]
        ),
        .library(
            name: "WindmillDataAccessInMemory",
            targets: ["WindmillDataAccessInMemory"]
        ),
        .library(
            name: "WindmillDataAccessSqlite",
            targets: ["WindmillDataAccessSqlite"]
        ),
        .library(
            name: "WindmillDependencyInjection",
            targets: ["WindmillDependencyInjection"]
        ),
        .library(
            name: "WindmillEventing",
            targets: ["WindmillEventing"]
        ),
        .library(
            name: "WindmillFlow",
            targets: ["WindmillFlow"]
        ),
        .library(
            name: "WindmillLab",
            targets: ["WindmillLab"]
        ),
        .library(
            name: "WindmillLogging",
            targets: ["WindmillLogging"]
        ),
        .library(
            name: "WindmillMemoryCache",
            targets: ["WindmillMemoryCache"]
        ),
        .library(
            name: "WindmillMessaging",
            targets: ["WindmillMessaging"]
        ),
        .library(
            name: "WindmillMetrics",
            targets: ["WindmillMetrics"]
        ),
        .library(
            name: "WindmillServer",
            targets: ["WindmillServer"]
        ),
        .library(
            name: "WindmillServerHummingbird",
            targets: ["WindmillServerHummingbird"]
        ),
        .library(
            name: "WindmillServerNio",
            targets: ["WindmillServerNio"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "0.13.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "WindmillClient",
            dependencies: [
                "WindmillCodec",
                "WindmillServer"
            ]
        ),
        .target(
            name: "WindmillCodec",
            dependencies: []
        ),
        .target(
            name: "WindmillConfiguration",
            dependencies: ["WindmillCodec"]
        ),
        .target(
            name: "WindmillConsole",
            dependencies: ["WindmillCore"]
        ),
        .target(
            name: "WindmillContext",
            dependencies: []
        ),
        .target(
            name: "WindmillCore",
            dependencies: [
                "WindmillCodec",
                "WindmillConfiguration",
                "WindmillDependencyInjection"
            ]
        ),
        .target(
            name: "WindmillDataAccess",
            dependencies: []
        ),
        .target(
            name: "WindmillDataAccessInMemory",
            dependencies: ["WindmillDataAccess"]
        ),
        .target(
            name: "WindmillDataAccessSqlite",
            dependencies: ["WindmillDataAccess"]
        ),
        .target(
            name: "WindmillDependencyInjection",
            dependencies: []
        ),
        .target(
            name: "WindmillEventing",
            dependencies: [
                "WindmillConfiguration",
                "WindmillCore",
                "WindmillDependencyInjection"
            ]
        ),
        .target(
            name: "WindmillFlow",
            dependencies: ["WindmillContext"]
        ),
        .target(
            name: "WindmillLab",
            dependencies: [
                "WindmillConfiguration",
                "WindmillCore",
                "WindmillDependencyInjection"
            ]
        ),
        .target(
            name: "WindmillLogging",
            dependencies: [
                "WindmillConfiguration",
                "WindmillCore",
                "WindmillDependencyInjection"
            ]
        ),
        .target(
            name: "WindmillMemoryCache",
            dependencies: [
                "WindmillConfiguration",
                "WindmillCore",
                "WindmillDataAccess",
                "WindmillDependencyInjection"
            ]
        ),
        .target(
            name: "WindmillMessaging",
            dependencies: [
                "WindmillConfiguration",
                "WindmillCore",
                "WindmillDependencyInjection"
            ]
        ),
        .target(
            name: "WindmillMetrics",
            dependencies: [
                "WindmillConfiguration",
                "WindmillCore",
                "WindmillDependencyInjection"
            ]
        ),
        .target(
            name: "WindmillServer",
            dependencies: [
                "WindmillContext",
                "WindmillCore"
            ]
        ),
        .target(
            name: "WindmillServerHummingbird",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdFoundation", package: "hummingbird"),
                "WindmillServer"
            ]
        ),
        .target(
            name: "WindmillServerNio",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdFoundation", package: "hummingbird"),
                "WindmillServer"
            ]
        ),

        .testTarget(
            name: "CodecTests",
            dependencies: ["WindmillCodec"]
        ),
        .testTarget(
            name: "FlowTests",
            dependencies: ["WindmillFlow"]
        ),
    ]
)