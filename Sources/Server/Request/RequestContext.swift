import Context

public class RequestContext: BaseContext {
    private let _body: Any?;
    private let _method: HttpMethod;
    private let _url: String;
    private let _headers: [String:[String]];
    private let _route: [String:String]

    internal init(
        withBody body: Any?,
        withMethod method: HttpMethod,
        withUrl url: String,
        withHeaders headers: [String:[String]],
        withRoute route: [String:String]
    ) {
        _body = body;
        _method = method;
        _url = url;
        _headers = headers;
        _route = route;
    }

    public func GetBody<TModel>() throws -> TModel? {
        if
            let body = _body,
            let model = body as? TModel
        {
            return model;
        }

        return nil;
    }

    public func GetMethod() -> HttpMethod {
        return _method;
    }

    public func GetUrl() -> String {
        return _url;
    }

    public func GetHeaders(key: String) ->  [String] {
        return _headers[key] ?? [];
    }

    public func GetRouteParameter(key: String) -> String {
        return _route[key] ?? "";
    }
}