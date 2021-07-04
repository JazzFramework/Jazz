import Server;

public class LoggingMiddleware2: Middleware {
    public final override func Logic(
        for request: RequestContext,
        with next: (RequestContext) throws -> ResultContext
    ) throws -> ResultContext {
        print("logging middleware 2\n")

        return try next(request);
    }
}