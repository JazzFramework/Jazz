import WindmillContext

public class RequestContext: BaseContext {
    private let body: Any?;
    private let method: HttpMethod;
    private let url: String;
    private let headers: [String:[String]];
    private let route: [String:String]

    internal init(
        withBody body: Any?,
        withMethod method: HttpMethod,
        withUrl url: String,
        withHeaders headers: [String:[String]],
        withRoute route: [String:String]
    ) {
        self.body = body;
        self.method = method;
        self.url = url;
        self.headers = headers;
        self.route = route;
    }

    public func getBody<TModel>() throws -> TModel? {
        if let body = body, let model = body as? TModel {
            return model;
        }

        return nil;
    }

    public func getMethod() -> HttpMethod {
        return method;
    }

    public func getUrl() -> String {
        return url;
    }

    public func getHeaders(key: String) ->  [String] {
        return headers[key] ?? [];
    }

    public func getRouteParameter(key: String) -> String {
        return route[key] ?? "";
    }
}