import JazzCodec;
import JazzContext;

public final class ResultContext: BaseContext {
    private let output: ResultStream;
    private let transcoderCollection: TranscoderCollection;
    private let cookieProcessor: CookieProcessor;
    private let acceptMediaTypes: [MediaType];

    private var statusCode: UInt;
    private var headers: [String:[String]];
    private var cookies: [SetCookie];

    internal init(
        _ output: ResultStream,
        _ transcoderCollection: TranscoderCollection,
        _ cookieProcessor: CookieProcessor,
        _ acceptMediaTypes: [MediaType]    
    ) {
        self.output = output;
        self.transcoderCollection = transcoderCollection;
        self.cookieProcessor = cookieProcessor;
        self.acceptMediaTypes = acceptMediaTypes;

        self.statusCode = 0;
        self.headers = [:];
        self.cookies = [];

        super.init();
    }

    public final func getStatusCode() -> UInt {
        return statusCode;
    }

    public final func getOutputStream() -> ResultStream {
        return output;
    }

    public final func getHeaders() -> [String:[String]] {
        return headers;
    }

    public final func set<T>(body: T) async throws {
        let mediaType: MediaType = try await transcoderCollection.encode(body, for: acceptMediaTypes, to: output);

        set(headerKey: "Content-Type", headerValue: mediaType.description);
    }

    public final func set(statusCode: UInt) {
        self.statusCode = statusCode;
    }

    public final func set(headerKey: String, headerValue: String) {
        if !headers.keys.contains(headerKey) {
            headers[headerKey] = [];
        }

        headers[headerKey]?.append(headerValue);
    }

    public final func set(cookie: SetCookie) {
        let setCookieValue: String = cookieProcessor.buildSetCookie(from: cookie);

        set(headerKey: "Set-Cookie", headerValue: setCookieValue);
    }
}