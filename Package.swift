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


        //ExampleService
        .library(
            name: "ExampleThirdPartyServerAuthentication",
            targets: ["ExampleThirdPartyServerAuthentication"]
        ),
        .library(
            name: "ExampleThirdPartyServerRequestLogging",
            targets: ["ExampleThirdPartyServerRequestLogging"]
        ),
        .library(
            name: "ExampleCommon",
            targets: ["ExampleCommon"]
        ),
        .library(
            name: "ExampleServer",
            targets: ["ExampleServer"]
        ),
        .library(
            name: "ExampleServerActionsCreateWeather",
            targets: ["ExampleServerActionsCreateWeather"]
        ),
        .library(
            name: "ExampleServerActionsDeleteWeather",
            targets: ["ExampleServerActionsDeleteWeather"]
        ),
        .library(
            name: "ExampleServerActionsGetWeather",
            targets: ["ExampleServerActionsGetWeather"]
        ),
        .library(
            name: "ExampleServerActionsGetWeathers",
            targets: ["ExampleServerActionsGetWeathers"]
        ),
        .library(
            name: "ExampleServerActionsUpdateWeather",
            targets: ["ExampleServerActionsUpdateWeather"]
        ),
        .library(
            name: "ExampleServerHelloWorldBackgroundProcess",
            targets: ["ExampleServerHelloWorldBackgroundProcess"]
        ),
        .library(
            name: "ExampleServerDataAccess",
            targets: ["ExampleServerDataAccess"]
        ),
        .executable(
            name: "ExampleServerHosting",
            targets: ["ExampleServerHosting"]
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
            dependencies: ["Codec"]
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
            dependencies: [
                "Codec",
                "Configuration",
                "Context",
                "DependencyInjection"
            ]
        ),
        .target(
            name: "ServerNio",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdFoundation", package: "hummingbird"),

                "Server"
            ]
        ),


        //ExampleService
        .target(
            name: "ExampleThirdPartyServerAuthentication",
            dependencies: [
                "Server"
            ],
            path: "Examples/ThirdParty/Server.Authentication"
        ),
        .target(
            name: "ExampleThirdPartyServerRequestLogging",
            dependencies: [
                "Server"
            ],
            path: "Examples/ThirdParty/Server.RequestLogging"
        ),
        .target(
            name: "ExampleCommon",
            dependencies: [
                "Codec"
            ],
            path: "Examples/TestService/External/Common"
        ),
        .target(
            name: "ExampleServer",
            dependencies: [
                "ExampleCommon"
            ],
            path: "Examples/TestService/External/Server"
        ),
        .target(
            name: "ExampleServerActionsCreateWeather",
            dependencies: [
                "Flow",
                "Server",

                "ExampleCommon",
                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.Actions.CreateWeather"
        ),
        .target(
            name: "ExampleServerActionsDeleteWeather",
            dependencies: [
                "Server",

                "ExampleCommon",
                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.Actions.DeleteWeather"
        ),
        .target(
            name: "ExampleServerActionsGetWeather",
            dependencies: [
                "Server",

                "ExampleCommon",
                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.Actions.GetWeather"
        ),
        .target(
            name: "ExampleServerActionsGetWeathers",
            dependencies: [
                "Server",

                "ExampleCommon",
                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.Actions.GetWeathers"
        ),
        .target(
            name: "ExampleServerActionsUpdateWeather",
            dependencies: [
                "Server",

                "ExampleCommon",
                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.Actions.UpdateWeather"
        ),
        .target(
            name: "ExampleServerHelloWorldBackgroundProcess",
            dependencies: [
                "ErrorHandling",
                "Server",

                "ExampleCommon",
                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.HelloWorldBackgroundProcess"
        ),
        .target(
            name: "ExampleServerDataAccess",
            dependencies: [
                "DataAccessInMemory",
                "Server",

                "ExampleCommon",
                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.DataAccess"
        ),
        .target(
            name: "ExampleServerHosting",
            dependencies: [
                "Server",
                "ServerNio",

                "ExampleThirdPartyServerAuthentication",
                "ExampleThirdPartyServerRequestLogging",

                "ExampleCommon",
                "ExampleServer",
                "ExampleServerActionsCreateWeather",
                "ExampleServerActionsDeleteWeather",
                "ExampleServerActionsGetWeather",
                "ExampleServerActionsGetWeathers",
                "ExampleServerActionsUpdateWeather",
                "ExampleServerHelloWorldBackgroundProcess",
                "ExampleServerDataAccess"
            ],
            path: "Examples/TestService/Internal/Server.Hosting",
            resources: [
                .process("appsettings.json")
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