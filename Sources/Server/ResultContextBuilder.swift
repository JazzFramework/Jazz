public class ResultContextBuilder {
    private var _statusCode: Int = 204;
    private var _body: Any? = nil;

    public init() {
    }

    public func With(statusCode: Int) -> ResultContextBuilder {
        _statusCode = statusCode;

        return self;
    }

    public func With(body: Any?) -> ResultContextBuilder {
        _body = body;

        return self;
    }

    public func Build() -> ResultContext {
        if let body: Any = _body {
            return ResultContext(
                withStatusCode: _statusCode,
                withBody: body
            );
        }

        return ResultContext(
            withStatusCode: _statusCode
        );
    }
}