import Codec;
import DependencyInjection;

public class AppRunner {
    private let _app: App;
    private let _initializers: [Initializer];
    private let _builtInInitializers: [Initializer];

    public init(withApp app: App, withInitializers initializers: [Initializer]) {
        _app = app;
        _initializers = initializers;

        _builtInInitializers = [
            DefaultCodecsInitializer(),
            DefaultErrorTranslatorsInitializer()
        ];
    }

    public func Run() throws {
        for initializer in _initializers {
            try initializer.Initialize(for: _app);
        }

        for initializer in _builtInInitializers {
            try initializer.Initialize(for: _app);
        }

        try _app.Run();
    }
}