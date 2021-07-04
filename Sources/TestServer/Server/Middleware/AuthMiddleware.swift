import Server;

public class AuthMiddleware: Middleware {
    public final override func Logic(
        for request: RequestContext,
        with next: (RequestContext) throws -> ResultContext
    ) throws -> ResultContext {
        if Int.random(in: 1..<100) % 2 == 0 {
            throw AuthErrors.notAuthorized(reason: "Randomly failing authorization check as an example for error handling in middlewares");
        }

        return try next(request);
    }
}