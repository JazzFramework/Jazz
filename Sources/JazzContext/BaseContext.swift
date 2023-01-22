open class BaseContext {
    private var subContexts: [String: BaseContext];

    public init() {
        subContexts = [:];
    }

    public func adopt<TContext: BaseContext>(subcontext context: TContext) {
        subContexts[String(describing: type(of: context))] = context;
    }

    public func fetch<TContext: BaseContext>() -> TContext? {
        if let context = subContexts[String(describing: TContext.self)], let tContext = context as? TContext {
            return tContext;
        }

        return nil;
    }
}