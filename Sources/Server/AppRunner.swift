import Codec;
import DependencyInjection;

public class AppRunner {
    private let _app: App;
    private let _initializers: [Initializer];

    public init(withApp app: App, withInitializers initializers: [Initializer]) {
        _app = app;
        _initializers = initializers;
    }

    public func Run() throws {
        for initializer in _initializers {
            try initializer.Initialize(for: _app);
        }

        try _app.Run();
    }
}