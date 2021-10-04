public class RequestContextBuilder {
    private var _body: Any? = nil;
    private var _method: HttpMethod? = nil;
    private var _url: String? = nil;
    private var _headers: [String:[String]] = [:]
    private var _route: [String:String] = [:];

    public init() {
    }

    public func with(body: Any?) -> RequestContextBuilder {
        _body = body;

        return self;
    }

    public func with(method: HttpMethod) -> RequestContextBuilder {
        _method = method;

        return self;
    }

    public func with(url: String) -> RequestContextBuilder {
        _url = url;

        return self;
    }

    public func with(header: String, values: [String]) -> RequestContextBuilder {
        if var collection = _headers[header] {
            for value in values {
                collection.append(value);
            }
        } else {
            _headers[header] = values;
        }

        return self;
    }

    public func with(route: String, value: String) -> RequestContextBuilder {
        _route[route] = value;

        return self;
    }

    public func build() -> RequestContext {
        return RequestContext(
            withBody: _body,
            withMethod: _method ?? .get,
            withUrl: _url ?? "",
            withHeaders: _headers,
            withRoute: _route
        );
    }
}