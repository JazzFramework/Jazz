import Foundation;

import JazzConfiguration;
import JazzCodec;
import JazzCore;
import JazzDependencyInjection;

public final class ServerAppRunner {
    private let app: ServerApp;
    private let configBuilder: ConfigurationBuilder;
    private let initializers: [String];

    public init(
        withApp app: ServerApp,
        withInitializers initializers: [String],
        withConfiguration configurationBuilder: ConfigurationBuilder
    ) {
        self.app = app;
        self.configBuilder = configurationBuilder;
        self.initializers = initializers;
    }

    public final func run() async throws {
        for initializer in initializers {
            if let initializer: Initializer = ServerAppRunner.initializerFromString(initializer) {
                try initializer.initialize(for: app, with: configBuilder);
            }
            else  if let initializer: ServerInitializer = ServerAppRunner.serverInitializerFromString(initializer) {
                try initializer.initialize(for: app, with: configBuilder);
            }
            else {
                print("Could not load initializer: \(initializer).");
            }
        }

        _ = try app
            .wireUp(singleton: { _ in
                return try self.configBuilder.build();
            });

        try await app.run();
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