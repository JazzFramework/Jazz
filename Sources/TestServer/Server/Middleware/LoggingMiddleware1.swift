import Server;

public class LoggingMiddleware1: Middleware {
    public final override func Logic(
        for request: RequestContext,
        with next: (RequestContext) throws -> ResultContext
    ) throws -> ResultContext {
        print("logging middleware 1\n")

        return try next(request);
    }
}