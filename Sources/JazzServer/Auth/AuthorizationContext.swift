import JazzContext;

public final class AuthorizationContext: BaseContext {
    private final let rights: [String];

    public init(rights: [String]) {
        self.rights = rights;
    }

    public func getRights() -> [String] {
        return rights;
    }
}