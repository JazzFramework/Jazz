open class Middleware {
    public init() {}

    open func Logic(
        for request: RequestContext,
        with next: (RequestContext) async throws -> ResultContext
    ) async throws -> ResultContext {
        return try await next(request);
    }
}