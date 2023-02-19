import Foundation;

import JazzConfiguration;
import JazzCore;

public class ConsoleAppRunner {
    private let app: ConsoleApp;
    private let configBuilder: ConfigurationBuilder;
    private let initializers: [String];

    public init(
        withApp app: ConsoleApp,
        withInitializers initializers: [String],
        withConfiguration configurationBuilder: ConfigurationBuilder
    ) {
        self.app = app;
        self.configBuilder = configurationBuilder;
        self.initializers = initializers;
    }

    public func run() async throws {
        for initializer in initializers {
            if let initializer: Initializer = ConsoleAppRunner.initializerFromString(initializer) {
                try initializer.initialize(for: app, with: configBuilder);
            }
            else  if let initializer: ConsoleInitializer = ConsoleAppRunner.consoleInitializerFromString(initializer) {
                try initializer.initialize(for: app, with: configBuilder);
            }
            else {
                print("Could not load initializer: \(initializer).");
            }
        }

        try await app.run(configuration: try configBuilder.build());
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