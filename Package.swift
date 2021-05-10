// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Flow",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Cache",
            targets: ["Cache"]
        ),
        .library(
            name: "Client",
            targets: ["Client"]
        ),
        .library(
            name: "Codec",
            targets: ["Codec"]
        ),
        .library(
            name: "Configuration",
            targets: ["Configuration"]
        ),
        .library(
            name: "Context",
            targets: ["Context"]
        ),
        .library(
            name: "DataAccess",
            targets: ["DataAccess"]
        ),
        .library(
            name: "DataAccessHttp",
            targets: ["DataAccessHttp"]
        ),
        .library(
            name: "DataAccessInMemory",
            targets: ["DataAccessInMemory"]
        ),
        .library(
            name: "DataAccessPgSql",
            targets: ["DataAccessPgSql"]
        ),
        .library(
            name: "DependencyInjection",
            targets: ["DependencyInjection"]
        ),
        .library(
            name: "ErrorHandling",
            targets: ["ErrorHandling"]
        ),
        .library(
            name: "Flow",
            targets: ["Flow"]
        ),
        .library(
            name: "Messaging",
            targets: ["Messaging"]
        ),
        .library(
            name: "Server",
            targets: ["Server"]
        ),
        .library(
            name: "ServerNio",
            targets: ["ServerNio"]
        ),
        .executable(
            name: "TestServer",
            targets: ["TestServer"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Cache",
            dependencies: []
        ),
        .target(
            name: "Client",
            dependencies: ["Codec", "Context", "DataAccess"]
        ),
        .target(
            name: "Codec",
            dependencies: []
        ),
        .target(
            name: "Configuration",
            dependencies: []
        ),
        .target(
            name: "Context",
            dependencies: []
        ),
        .target(
            name: "DataAccess",
            dependencies: []
        ),
        .target(
            name: "DataAccessHttp",
            dependencies: ["DataAccess"]
        ),
        .target(
            name: "DataAccessInMemory",
            dependencies: ["DataAccess"]
        ),
        .target(
            name: "DataAccessPgSql",
            dependencies: ["DataAccess"]
        ),
        .target(
            name: "DependencyInjection",
            dependencies: []
        ),
        .target(
            name: "ErrorHandling",
            dependencies: []
        ),
        .target(
            name: "Flow",
            dependencies: ["Context"]
        ),
        .target(
            name: "Messaging",
            dependencies: []
        ),
        .target(
            name: "Server",
            dependencies: ["Codec", "Context", "DependencyInjection"]
        ),
        .target(
            name: "ServerNio",
            dependencies: [
                "Server",
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "NIOHTTP1", package: "swift-nio")
            ]
        ),
        .target(
            name: "TestServer",
            dependencies: [
                "Server",
                "ServerNio"
            ]
        ),

        .testTarget(
            name: "CodecTests",
            dependencies: ["Codec"]
        ),
        .testTarget(
            name: "FlowTests",
            dependencies: ["Flow"]
        ),
    ]
)