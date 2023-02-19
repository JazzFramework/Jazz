import JazzConfiguration;
import JazzCore;

public final class LoggerInitializer: Initializer {
    public required init() {}

    public override final func initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .wireUp(singleton: { _, _ in return ConsoleLoggerProvider() as LoggerProvider; })
            .wireUp(singleton: { _, sp in return LoggerImpl(loggerProvider: try await sp.fetchType()) as Logger; });
    }
}