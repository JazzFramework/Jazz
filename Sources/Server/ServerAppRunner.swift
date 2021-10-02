import Foundation;

import Codec;
import Configuration;
import DependencyInjection;

public class ServerAppRunner {
    private let _app: ServerApp;
    private let _configBuilder: ConfigurationBuilder;
    private let _initializers: [String];
    private let _builtInInitializers: [Initializer];
    private let _builtInInitializerServers: [ServerInitializer];

    public init(
        withApp app: ServerApp,
        withInitializers initializers: [String],
        withConfiguration configurationBuilder: ConfigurationBuilder
    ) {
        _app = app;
        _configBuilder = configurationBuilder;

        _initializers = initializers;

        _builtInInitializers = [
            DefaultCodecsInitializer()
        ];

        _builtInInitializerServers = [
            DefaultErrorTranslatorsInitializer()
        ];
    }

    public func Run() async throws {
        for initializer in _initializers {
            if let initializer: Initializer = ServerAppRunner.initializerFromString(initializer) {
                try initializer.Initialize(for: _app, with: _configBuilder);
            }
            else  if let initializer: ServerInitializer = ServerAppRunner.serverInitializerFromString(initializer) {
                try initializer.Initialize(for: _app, with: _configBuilder);
            }
            else {
                print("Could not load initializer: \(initializer).");
            }
        }

        for initializer in _builtInInitializers {
            try initializer.Initialize(for: _app, with: _configBuilder);
        }

        for initializer in _builtInInitializerServers {
            try initializer.Initialize(for: _app, with: _configBuilder);
        }

        _ = try _app
            .WireUp(singleton: { _ in
                return try self._configBuilder.Build();
            });

        try await _app.Run();
    }

    private static func initializerFromString(_ className: String) -> Initializer? {
        if let cls: Initializer.Type = NSClassFromString(className) as? Initializer.Type {
            return cls.init();
        }

        return nil;
    }

    private static func serverInitializerFromString(_ className: String) -> ServerInitializer? {
        if let cls: ServerInitializer.Type = NSClassFromString(className) as? ServerInitializer.Type {
            return cls.init();
        }

        return nil;
    }
}