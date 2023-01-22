public final class ApiControllerResultBuilder {
    private var statusCode: UInt = 0;
    private var body: Any? = nil;

    private var headers: [String:[String]] = [:];

    public init() {}

    public final func with(statusCode: UInt) -> ApiControllerResultBuilder {
        self.statusCode = statusCode;

        return self;
    }

    public final func with(body: Any) -> ApiControllerResultBuilder {
        self.body = body;

        return self;
    }

    public final func with(headerKey: String, headerValue: String) -> ApiControllerResultBuilder {
        if !headers.keys.contains(headerKey) {
            headers[headerKey] = [];
        }

        headers[headerKey]?.append(headerValue);

        return self;
    }

    public final func with(headers: [String:[String]]) -> ApiControllerResultBuilder {
        for (key, values) in headers {
            for value in values {
                _ = with(headerKey: key, headerValue: value);
            }
        }

        return self;
    }

    public final func build() -> ApiControllerResult {
        return ApiControllerResult(statusCode, body, headers);
    }
}