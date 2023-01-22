import Foundation;

public final class HtmlControllerResultBuilder {
    private var statusCode: UInt = 0;
    private var headers: [String:[String]] = [:];
    private var body: HtmlStream = EmptyHtmlStream();

    public init() {}

    public final func with(statusCode: UInt) -> HtmlControllerResultBuilder {
        self.statusCode = statusCode;

        return self;
    }

    public final func with(headerKey: String, headerValue: String) -> HtmlControllerResultBuilder {
        if !headers.keys.contains(headerKey) {
            headers[headerKey] = [];
        }

        headers[headerKey]?.append(headerValue);

        return self;
    }

    public final func with(headers: [String:[String]]) -> HtmlControllerResultBuilder {
        for (key, values) in headers {
            for value in values {
                _ = with(headerKey: key, headerValue: value);
            }
        }

        return self;
    }

    public final func with(body: HtmlStream) -> HtmlControllerResultBuilder {
        self.body = body;

        return self;
    }

    public final func build() -> HtmlControllerResult {
        return HtmlControllerResult(statusCode, headers, body);
    }
}