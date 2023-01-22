open class Middleware {
    public init() {}

    open func logic(
        for request: RequestContext,
        into result: ResultContext,
        with next: (RequestContext, ResultContext) async throws -> ()
    ) async throws {
        try await next(request, result);
    }
}