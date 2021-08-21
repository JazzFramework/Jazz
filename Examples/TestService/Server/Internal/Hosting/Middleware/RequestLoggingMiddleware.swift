import Server;

public class RequestLoggingMiddleware: Middleware {
    public final override func Logic(
        for request: RequestContext,
        with next: (RequestContext) throws -> ResultContext
    ) throws -> ResultContext {
        print("[\(request.GetMethod())] \(request.GetUrl()) called");

        return try next(request);
    }
}