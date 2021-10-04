import Foundation;

import WindmillConfiguration;
import WindmillCore;
import WindmillCodec;
import WindmillDependencyInjection;

public class ConsoleAppRunner {
    private let _app: ConsoleApp;
    private let _configBuilder: ConfigurationBuilder;
    private let _initializers: [String];

    public init(
        withApp app: ConsoleApp,
        withInitializers initializers: [String],
        withConfiguration configurationBuilder: ConfigurationBuilder
    ) {
        _app = app;
        _configBuilder = configurationBuilder;
        _initializers = initializers;
    }

    public func run() async throws {
        for initializer in _initializers {
            if let initializer: Initializer = ConsoleAppRunner.initializerFromString(initializer) {
                try initializer.initialize(for: _app, with: _configBuilder);
            }
            else  if let initializer: ConsoleInitializer = ConsoleAppRunner.consoleInitializerFromString(initializer) {
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

    private static func consoleInitializerFromString(_ className: String) -> ConsoleInitializer? {
        if let cls: ConsoleInitializer.Type = NSClassFromString(className) as? ConsoleInitializer.Type {
            return cls.init();
        }

        return nil;
    }
}