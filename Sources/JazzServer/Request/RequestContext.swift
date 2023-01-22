import Foundation;

import JazzCodec;
import JazzContext;

public final class RequestContext: BaseContext {
    private let rawInput: RequestStream;
    private let method: HttpMethod;
    private let url: String;
    private let headers: [String:[String]];
    private let transcoderCollection: TranscoderCollection;
    private let cookieProcessor: CookieProcessor;
    private var cookies: [Cookie]?;

    private var route: [String:String];

    internal init(
        withRawInput rawInput: RequestStream,
        withMethod method: HttpMethod,
        withUrl url: String,
        withHeaders headers: [String:[String]],
        withRoute route: [String:String],
        withTranscoderCollection transcoderCollection: TranscoderCollection,
        withCookieProcessor cookieProcessor: CookieProcessor
    ) {
        self.rawInput = rawInput;
        self.method = method;
        self.url = url;
        self.headers = headers;
        self.route = route;
        self.transcoderCollection = transcoderCollection;
        self.cookieProcessor = cookieProcessor;
        self.cookies = nil;
    }

    public final func getRawInput() -> RequestStream {
        return rawInput;
    }

    public final func getBody<T>() async throws -> T {
        if let mediaType = getContentType() {
            return try await transcoderCollection.decode(for: mediaType, from: rawInput);
        }

        throw HttpErrors.unsupportedMediaType;
    }

    public final func getMethod() -> HttpMethod {
        return method;
    }

    public final func getUrl() -> String {
        return url;
    }

    public final func getHeaders(key: String) ->  [String] {
        return headers[key] ?? [];
    }

    public final func getCookies() -> [Cookie] {
        guard let cookies = cookies else {
            let builtCookies = buildCookieArray();

            cookies = builtCookies;

            return builtCookies;
        }

        return cookies;
    }

    public final func getRouteParameter(key: String) -> String {
        return route[key] ?? "";
    }

    internal final func updateRouteParameter(key: String, value: String) {
        route[key] = value;
    }

    private final func buildCookieArray() -> [Cookie] {
        return cookieProcessor.buildCookies(from: headers["Cookie"] ?? []);
    }

    private final func getContentType() -> MediaType? {
        return getMediaType(for: "Content-Type");
    }

    private final func getMediaType(for property: String) -> MediaType? {
        if let header = headers[property]?.first {
            return MediaType(parseFrom: header);
        }

        return nil;
    }
}