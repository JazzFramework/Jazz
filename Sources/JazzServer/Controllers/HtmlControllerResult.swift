public final class HtmlControllerResult {
    private let statusCode: UInt;
    private let headers: [String:[String]];
    private let body: HtmlStream;

    internal init(_ statusCode: UInt, _ headers: [String:[String]], _ body: HtmlStream) {
        self.statusCode = statusCode;
        self.headers = headers;
        self.body = body;
    }

    public final func getStatusCode() -> UInt {
        return statusCode;
    }

    public final func getHeaders() -> [String:[String]] {
        return headers;
    }

    public final func getBody() -> HtmlStream {
        return body;
    }
}