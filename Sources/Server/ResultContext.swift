import Context

public class ResultContext: BaseContext {
    private let _statusCode: Int;
    private let _body: Any?;

    internal init(withStatusCode statusCode: Int) {
        _statusCode = statusCode;
        _body = nil;
    }

    internal init(
        withStatusCode statusCode: Int,
        withBody body: Any
    ) {
        _statusCode = statusCode;
        _body = body;
    }

    public func GetStatusCode() -> Int {
        return _statusCode;
    }

    public func GetBody() -> Any? {
        return _statusCode;
    }
}