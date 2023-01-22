import Foundation;

import JazzCodec;

public final class RequestContextBuilder {
    private var rawInput: RequestStream? = nil;
    private var method: HttpMethod? = nil;
    private var url: String? = nil;
    private var headers: [String:[String]] = [:]
    private var route: [String:String] = [:];
    private var transcoderCollection: TranscoderCollection? = nil;
    private var cookieProcessor: CookieProcessor? = nil;

    public init() {
    }

    public final func with(rawInput: RequestStream) -> RequestContextBuilder {
        self.rawInput = rawInput;

        return self;
    }

    public final func with(method: HttpMethod) -> RequestContextBuilder {
        self.method = method;

        return self;
    }

    public final func with(url: String) -> RequestContextBuilder {
        self.url = url;

        return self;
    }

    public final func with(header: String, values: [String]) -> RequestContextBuilder {
        if var collection = headers[header] {
            for value in values {
                collection.append(value);
            }
        } else {
            headers[header] = values;
        }

        return self;
    }

    public final func with(route: String, value: String) -> RequestContextBuilder {
        self.route[route] = value;

        return self;
    }

    public final func with(transcoderCollection: TranscoderCollection) -> RequestContextBuilder {
        self.transcoderCollection = transcoderCollection;

        return self;
    }

    public final func with(cookieProcessor: CookieProcessor) -> RequestContextBuilder {
        self.cookieProcessor = cookieProcessor;

        return self;
    }

    public final func build() throws -> RequestContext {
        if let transcoderCollection = transcoderCollection, let cookieProcessor = cookieProcessor, let rawInput = rawInput {
            return RequestContext(
                withRawInput: rawInput,
                withMethod: method ?? .get,
                withUrl: url ?? "",
                withHeaders: headers,
                withRoute: route,
                withTranscoderCollection: transcoderCollection,
                withCookieProcessor: cookieProcessor
            );
        }

        throw HttpErrors.unsupportedMediaType;
    }
}