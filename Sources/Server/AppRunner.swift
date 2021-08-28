import Foundation;

import Codec;
import Configuration;
import DependencyInjection;

public class AppRunner {
    private let _app: App;
    private let _configBuilder: ConfigurationBuilder;
    private let _initializers: [String];
    private let _builtInInitializers: [Initializer];

    public init(
        withApp app: App,
        withInitializers initializers: [String],
        withConfiguration configurationBuilder: ConfigurationBuilder
    ) {
        _app = app;
        _configBuilder = configurationBuilder;

        _initializers = initializers;

        _builtInInitializers = [
            DefaultCodecsInitializer(),
            DefaultErrorTranslatorsInitializer()
        ];
    }

    public func Run() throws {
        for initializer in _initializers {
            try AppRunner.classFromString(initializer)
                .Initialize(for: _app, with: _configBuilder);
        }

        for initializer in _builtInInitializers {
            try initializer.Initialize(for: _app, with: _configBuilder);
        }

        _ = try _app
            .WireUp(singleton: { _ in
                return try self._configBuilder.Build();
            });

        try _app.Run();
    }

    private static func classFromString(_ className: String) -> Initializer {
        let cls: Initializer.Type = NSClassFromString(className) as! Initializer.Type;

        return cls.init();
    }
}