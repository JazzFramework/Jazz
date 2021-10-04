import WindmillContext

public class ResultContext: BaseContext {
    private let statusCode: UInt;
    private let body: Any?;

    internal init(withStatusCode statusCode: UInt) {
        self.statusCode = statusCode;
        self.body = nil;
    }

    internal init(
        withStatusCode statusCode: UInt,
        withBody body: Any
    ) {
        self.statusCode = statusCode;
        self.body = body;
    }

    public func getStatusCode() -> UInt {
        return statusCode;
    }

    public func getBody() -> Any? {
        return body;
    }
}