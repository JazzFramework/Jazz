import Server;

public class LoggingMiddleware3: Middleware {
    public final override func Logic(
        for request: RequestContext,
        with next: (RequestContext) throws -> ResultContext
    ) throws -> ResultContext {
        print("logging middleware 3\n")

        return try next(request);
    }
}