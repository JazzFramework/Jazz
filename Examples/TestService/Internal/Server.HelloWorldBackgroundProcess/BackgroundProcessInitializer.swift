import Configuration;
import Server;

public class BackgroundProcessInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(backgroundProcess: { sp in
                return HelloWorldBackgroundProcess(
                    with: try sp.FetchType(),
                    with: try sp.FetchType()
                );
            });
    }
}