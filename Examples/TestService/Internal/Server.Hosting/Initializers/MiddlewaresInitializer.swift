import Configuration;
import Server;

public class MiddlewaresInitializer: Initializer {
    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(middleware: { _ in
                return MetricsMiddleware();
            });
    }
}