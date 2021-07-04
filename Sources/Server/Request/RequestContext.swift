import Context

public class RequestContext: BaseContext {
    private let _body: Any?;
    private let _method: HttpMethod;
    private let _url: String;

    internal init(
        withBody body: Any?,
        withMethod method: HttpMethod,
        withUrl url: String
    ) {
        _body = body;
        _method = method;
        _url = url;
    }

    public func GetBody<TModel>() throws -> TModel? {
        return nil;
    }

    public func GetMethod() -> HttpMethod {
        return _method;
    }

    public func GetUrl() -> String {
        return _url;
    }
}