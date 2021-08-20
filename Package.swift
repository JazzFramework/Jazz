// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Windmill",
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
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "0.11.0"),
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
            dependencies: ["Codec", "Context", "DependencyInjection", "DataAccess"]
        ),
        .target(
            name: "ServerNio",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdFoundation", package: "hummingbird"),

                "Server"
            ]
        ),
        .target(
            name: "TestServer",
            dependencies: [
                "DataAccessInMemory",
                "Flow",
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