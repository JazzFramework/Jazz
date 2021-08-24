open class Middleware {
    public init() {}

    open func Logic(
        for request: RequestContext,
        with next: (RequestContext) throws -> ResultContext
    ) throws -> ResultContext {
        return try next(request);
    }
}