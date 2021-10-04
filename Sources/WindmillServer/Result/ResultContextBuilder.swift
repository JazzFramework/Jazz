public class ResultContextBuilder {
    private var statusCode: UInt = 204;
    private var body: Any? = nil;

    public init() {}

    public func with(statusCode: UInt) -> ResultContextBuilder {
        self.statusCode = statusCode;

        return self;
    }

    public func with(body: Any?) -> ResultContextBuilder {
        self.body = body;

        return self;
    }

    public func build() -> ResultContext {
        if let body: Any = self.body {
            return ResultContext(
                withStatusCode: statusCode,
                withBody: body
            );
        }

        return ResultContext(
            withStatusCode: statusCode
        );
    }
}