public final class ApiControllerResult {
    private let statusCode: UInt;
    private let body: Any?;
    private let headers: [String:[String]];

    internal init(_ statusCode: UInt, _ body: Any?, _ headers: [String:[String]]) {
        self.statusCode = statusCode;
        self.body = body;
        self.headers = headers;
    }

    public final func getStatusCode() -> UInt {
        return statusCode;
    }

    public final func getBody() -> Any? {
        return body;
    }

    public final func getHeaders() -> [String:[String]] {
        return headers;
    }
}