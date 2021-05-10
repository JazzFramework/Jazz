import Context

public class RequestContext: BaseContext {
    private let _body: Any?;

    internal init(withBody body: Any?) {
        _body = body;
    }

    public func GetBody<TModel>() throws -> TModel? {
        return nil;
    }
}