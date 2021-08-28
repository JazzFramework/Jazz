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
            name: "ExampleClient",
            dependencies: [
                "Server",

                "ExampleCommon"
            ],
            path: "Examples/TestService/External/Client"
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

                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.Actions.CreateWeather"
        ),
        .target(
            name: "ExampleServerActionsDeleteWeather",
            dependencies: [
                "Server",

                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.Actions.DeleteWeather"
        ),
        .target(
            name: "ExampleServerActionsGetWeather",
            dependencies: [
                "Server",

                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.Actions.GetWeather"
        ),
        .target(
            name: "ExampleServerActionsGetWeathers",
            dependencies: [
                "Server",

                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.Actions.GetWeathers"
        ),
        .target(
            name: "ExampleServerActionsUpdateWeather",
            dependencies: [
                "Server",

                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.Actions.UpdateWeather"
        ),
        .target(
            name: "ExampleServerHelloWorldBackgroundProcess",
            dependencies: [
                "ErrorHandling",
                "Server",

                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.HelloWorldBackgroundProcess"
        ),
        .target(
            name: "ExampleServerDataAccessInMemory",
            dependencies: [
                "DataAccess",
                "Server",

                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.DataAccess.InMemory"
        ),
        .target(
            name: "ExampleServerErrorsWeatherErrorsWeatherInvalidTempErrorTranslator",
            dependencies: [
                "Server",

                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.Errors.WeatherErrors.WeatherInvalidTempErrorTranslator"
        ),
        .target(
            name: "ExampleServerHostingEndpoints",
            dependencies: [
                "Server",

                "ExampleServer"
            ],
            path: "Examples/TestService/Internal/Server.Hosting.Endpoints"
        ),
        .target(
            name: "ExampleServerHosting",
            dependencies: [
                "ServerNio",

                "ExampleThirdPartyServerAuthentication",
                "ExampleThirdPartyServerRequestLogging",

                "ExampleClient",
                "ExampleServer",
                "ExampleServerDataAccessInMemory",
                "ExampleServerActionsCreateWeather",
                "ExampleServerActionsDeleteWeather",
                "ExampleServerActionsGetWeather",
                "ExampleServerActionsGetWeathers",
                "ExampleServerActionsUpdateWeather",
                "ExampleServerErrorsWeatherErrorsWeatherInvalidTempErrorTranslator",
                "ExampleServerHelloWorldBackgroundProcess",
                "ExampleServerHostingEndpoints"
            ],
            path: "Examples/TestService/Internal/Server.Hosting",
            resources: [
                .process("Settings/appsettings.json")
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