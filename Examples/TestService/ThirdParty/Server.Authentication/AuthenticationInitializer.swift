import Server;

public class AuthenticationInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(errorTranslator: { _ in
                return NotAuthorizedErrorTranslator();
            })
            .WireUp(middleware: { _ in
                return AuthMiddleware();
            });
    }
}