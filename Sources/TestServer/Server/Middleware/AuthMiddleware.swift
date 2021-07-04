import Server;

public class AuthMiddleware: Middleware {
    public final override func Logic(
        for request: RequestContext,
        with next: (RequestContext) throws -> ResultContext
    ) throws -> ResultContext {
        return try next(request);
    }
}