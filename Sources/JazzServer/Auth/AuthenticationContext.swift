import JazzContext;

public final class AuthenticationContext: BaseContext {
    private final let identity: String;

    public init(identity: String) {
        self.identity = identity;
    }

    public func getIdentity() -> String {
        return identity;
    }
}