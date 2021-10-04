open class ContextResolver<TStart: BaseContext, TEnd: BaseContext> {
    public init() {}

    open func resolve(for context: TStart) -> TEnd? {
        return context.fetch();
    }
}
