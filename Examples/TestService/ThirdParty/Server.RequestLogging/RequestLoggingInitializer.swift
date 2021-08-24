import Server;

public class RequestLoggingInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(middleware: { _ in
                return RequestLoggingMiddleware();
            });
    }
}