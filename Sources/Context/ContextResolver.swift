open class ContextResolver<TStart: BaseContext, TEnd: BaseContext> {
    public init() {}

    open func Resolve(for context: TStart) -> TEnd? {
        return context.Fetch();
    }
}
