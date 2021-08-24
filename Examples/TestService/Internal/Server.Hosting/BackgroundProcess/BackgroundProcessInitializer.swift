import Server;

public class BackgroundProcessInitializer: Initializer {
    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(backgroundProcess: { _ in
                return HelloWorldBackgroundProcess();
            });
    }
}