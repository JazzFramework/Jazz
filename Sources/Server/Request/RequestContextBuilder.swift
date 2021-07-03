public class RequestContextBuilder {
    private var _body: Any? = nil;

    public init() {
    }

    public func With(body: Any?) -> RequestContextBuilder {
        _body = body;

        return self;
    }

    public func Build() -> RequestContext {
        return RequestContext(
            withBody: _body
        );
    }
}