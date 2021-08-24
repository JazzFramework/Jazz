import Server;

public class BackgroundProcessInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(backgroundProcess: { sp in
                return HelloWorldBackgroundProcess(with: try sp.FetchType());
            });
    }
}