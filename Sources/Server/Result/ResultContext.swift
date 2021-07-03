import Context

public class ResultContext: BaseContext {
    private let _statusCode: UInt;
    private let _body: Any?;

    internal init(withStatusCode statusCode: UInt) {
        _statusCode = statusCode;
        _body = nil;
    }

    internal init(
        withStatusCode statusCode: UInt,
        withBody body: Any
    ) {
        _statusCode = statusCode;
        _body = body;
    }

    public func GetStatusCode() -> UInt {
        return _statusCode;
    }

    public func GetBody() -> Any? {
        return _body;
    }
}