// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

//TODO: Split out packages into multiple repos
let package = Package(
    name: "Jazz",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "JazzClient",
            targets: ["JazzClient"]
        ),
        .library(
            name: "JazzCodec",
            targets: ["JazzCodec"]
        ),
        .library(
            name: "JazzConfiguration",
            targets: ["JazzConfiguration"]
        ),
        .library(
            name: "JazzConsole",
            targets: ["JazzConsole"]
        ),
        .library(
            name: "JazzContext",
            targets: ["JazzContext"]
        ),
        .library(
            name: "JazzCore",
            targets: ["JazzCore"]
        ),
        .library(
            name: "JazzDataAccess",
            targets: ["JazzDataAccess"]
        ),
        .library(
            name: "JazzDataAccessDynamoDB",
            targets: ["JazzDataAccessDynamoDB"]
        ),
        .library(
            name: "JazzDataAccessInMemory",
            targets: ["JazzDataAccessInMemory"]
        ),
        .library(
            name: "JazzDataAccessSqlite",
            targets: ["JazzDataAccessSqlite"]
        ),
        .library(
            name: "JazzDependencyInjection",
            targets: ["JazzDependencyInjection"]
        ),
        .library(
            name: "JazzEventing",
            targets: ["JazzEventing"]
        ),
        .library(
            name: "JazzFlow",
            targets: ["JazzFlow"]
        ),
        .library(
            name: "JazzLab",
            targets: ["JazzLab"]
        ),
        .library(
            name: "JazzLocalization",
            targets: ["JazzLocalization"]
        ),
        .library(
            name: "JazzLogging",
            targets: ["JazzLogging"]
        ),
        .library(
            name: "JazzMemoryCache",
            targets: ["JazzMemoryCache"]
        ),
        .library(
            name: "JazzMessaging",
            targets: ["JazzMessaging"]
        ),
        .library(
            name: "JazzMetrics",
            targets: ["JazzMetrics"]
        ),
        .library(
            name: "JazzServer",
            targets: ["JazzServer"]
        ),
        .library(
            name: "JazzServerHummingbird",
            targets: ["JazzServerHummingbird"]
        ),
        .library(
            name: "JazzTemplatingEngineStencil",
            targets: ["JazzTemplatingEngineStencil"]
        ),
        .library(
            name: "JazzTest",
            targets: ["JazzTest"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.42.0"),
        .package(url: "https://github.com/apple/swift-nio-ssl.git", from: "2.6.0"),
        .package(url: "https://github.com/apple/swift-nio-http2.git", from: "1.9.0"),

        .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.15.1"),
        .package(url: "https://github.com/awslabs/aws-sdk-swift", from: "0.9.2"),


        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "0.13.1"),

        .package(name: "Mockingbird", url: "https://github.com/birdrides/mockingbird.git", .upToNextMinor(from: "0.20.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "JazzClient",
            dependencies: [
                "JazzCodec",
                "JazzServer"
            ]
        ),
        .target(
            name: "JazzCodec",
            dependencies: []
        ),
        .target(
            name: "JazzConfiguration",
            dependencies: ["JazzCodec"]
        ),
        .target(
            name: "JazzConsole",
            dependencies: ["JazzCore"]
        ),
        .target(
            name: "JazzContext",
            dependencies: []
        ),
        .target(
            name: "JazzCore",
            dependencies: [
                "JazzCodec",
                "JazzConfiguration",
                "JazzDependencyInjection"
            ]
        ),
        .target(
            name: "JazzDataAccess",
            dependencies: []
        ),
        .target(
            name: "JazzDataAccessDynamoDB",
            dependencies: [
                .product(name: "AWSDynamoDB", package: "aws-sdk-swift"),

                "JazzDataAccess"
            ]
        ),
        .target(
            name: "JazzDataAccessInMemory",
            dependencies: ["JazzDataAccess"]
        ),
        .target(
            name: "JazzDataAccessSqlite",
            dependencies: ["JazzDataAccess"]
        ),
        .target(
            name: "JazzDependencyInjection",
            dependencies: []
        ),
        .target(
            name: "JazzEventing",
            dependencies: [
                "JazzConfiguration",
                "JazzCore",
                "JazzDependencyInjection"
            ]
        ),
        .target(
            name: "JazzFlow",
            dependencies: ["JazzContext"]
        ),
        .target(
            name: "JazzLab",
            dependencies: [
                "JazzConfiguration",
                "JazzCore",
                "JazzDependencyInjection"
            ]
        ),
        .target(
            name: "JazzLocalization",
            dependencies: [
                "JazzConfiguration",
                "JazzCore",
                "JazzDependencyInjection"
            ]
        ),
        .target(
            name: "JazzLogging",
            dependencies: [
                "JazzConfiguration",
                "JazzCore",
                "JazzDependencyInjection"
            ]
        ),
        .target(
            name: "JazzMemoryCache",
            dependencies: [
                "JazzConfiguration",
                "JazzCore",
                "JazzDataAccess",
                "JazzDependencyInjection"
            ]
        ),
        .target(
            name: "JazzMessaging",
            dependencies: [
                "JazzConfiguration",
                "JazzCore",
                "JazzDependencyInjection"
            ]
        ),
        .target(
            name: "JazzMetrics",
            dependencies: [
                "JazzConfiguration",
                "JazzCore",
                "JazzDependencyInjection"
            ]
        ),
        .target(
            name: "JazzServer",
            dependencies: [
                "JazzContext",
                "JazzCore",
                "JazzDataAccess"
            ]
        ),
        .target(
            name: "JazzServerHummingbird",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdFoundation", package: "hummingbird"),

                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
                .product(name: "NIOHTTP2", package: "swift-nio-http2"),
                .product(name: "NIOSSL", package: "swift-nio-ssl"),

                "JazzServer"
            ]
        ),
        .target(
            name: "JazzTemplatingEngineStencil",
            dependencies: [
                .product(name: "Stencil", package: "Stencil"),

                "JazzServer"
            ]
        ),
        .target(
            name: "JazzTest",
            dependencies: [
                "JazzContext",
                "JazzCore"
            ]
        ),

        .testTarget(
            name: "FlowTests",
            dependencies: [
                "JazzFlow"
            ]
        ),
        .testTarget(
            name: "ServerTests",
            dependencies: [
                "Mockingbird",

                "JazzServer"
            ]
        )
    ]
)