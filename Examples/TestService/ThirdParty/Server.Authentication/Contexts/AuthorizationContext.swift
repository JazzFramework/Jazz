import Context

public final class AuthorizationContext: BaseContext {
    private let _token: String;

    internal init(
        withToken token: String
    ) {
        _token = token;
    }

    public func GetToken() -> String {
        return _token;
    }
}