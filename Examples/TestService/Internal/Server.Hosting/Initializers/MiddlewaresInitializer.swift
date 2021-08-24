import Server;

public class MiddlewaresInitializer: Initializer {
    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(middleware: { _ in
                return MetricsMiddleware();
            });
    }
}