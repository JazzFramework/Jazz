import Foundation;

import WindmillConfiguration;
import WindmillCodec;
import WindmillCore;
import WindmillDependencyInjection;

public class ServerAppRunner {
    private let _app: ServerApp;
    private let _configBuilder: ConfigurationBuilder;
    private let _initializers: [String];

    public init(
        withApp app: ServerApp,
        withInitializers initializers: [String],
        withConfiguration configurationBuilder: ConfigurationBuilder
    ) {
        _app = app;
        _configBuilder = configurationBuilder;
        _initializers = initializers;
    }

    public func run() async throws {
        for initializer in _initializers {
            if let initializer: Initializer = ServerAppRunner.initializerFromString(initializer) {
                try initializer.initialize(for: _app, with: _configBuilder);
            }
            else  if let initializer: ServerInitializer = ServerAppRunner.serverInitializerFromString(initializer) {
                try initializer.initialize(for: _app, with: _configBuilder);
            }
            else {
                print("Could not load initializer: \(initializer).");
            }
        }

        _ = try _app
            .wireUp(singleton: { _ in
                return try self._configBuilder.build();
            });

        try await _app.run();
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