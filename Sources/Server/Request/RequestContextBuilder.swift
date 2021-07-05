public class RequestContextBuilder {
    private var _body: Any? = nil;
    private var _method: HttpMethod? = nil;
    private var _url: String? = nil;
    private var _headers: [String:[String]] = [:]
    private var _route: [String:String] = [:];

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

    public func With(header: String, values: [String]) -> RequestContextBuilder {
        _headers[header] = values;

        return self;
    }

    public func With(route: String, value: String) -> RequestContextBuilder {
        _route[route] = value;

        return self;
    }

    public func Build() -> RequestContext {
        return RequestContext(
            withBody: _body,
            withMethod: _method ?? .get,
            withUrl: _url ?? "",
            withHeaders: _headers,
            withRoute: _route
        );
    }
}