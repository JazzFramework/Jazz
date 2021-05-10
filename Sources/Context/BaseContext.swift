open class BaseContext {
    private var _subContexts: [String: BaseContext];

    public init() {
        _subContexts = [:];
    }

    public func Adopt<TContext: BaseContext>(subcontext context: TContext) {
        _subContexts[String(describing: type(of: context))] = context;
    }

    public func Fetch<TContext: BaseContext>() -> TContext? {
        if let context = _subContexts[String(describing: TContext.self)] {
            if let tContext = context as? TContext {
                return tContext;
            }
        }

        return nil;
    }
}