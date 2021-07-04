public class RequestContextBuilder {
    private var _body: Any? = nil;
    private var _method: HttpMethod? = nil;
    private var _url: String? = nil;

    public init() {
    }

    public func With(body: Any?) -> RequestContextBuilder {
        _body = body;

        return self;
    }

    public func With(method: HttpMethod) -> RequestContextBuilder {
        _method = method;

        return self;
    }

    public func With(url: String) -> RequestContextBuilder {
        _url = url;

        return self;
    }

    public func Build() -> RequestContext {
        return RequestContext(
            withBody: _body,
            withMethod: _method ?? .get,
            withUrl: _url ?? ""
        );
    }
}