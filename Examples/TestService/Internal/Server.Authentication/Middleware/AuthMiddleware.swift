import Server;

internal final class AuthMiddleware: Middleware {
    public final override func Logic(
        for request: RequestContext,
        with next: (RequestContext) throws -> ResultContext
    ) throws -> ResultContext {
        let authorization = request.GetHeaders(key: "Authorization");

        if authorization.count > 0 && authorization[0] != "" {
            return try next(request);
        }
        else
        {
            throw AuthErrors.notAuthorized(reason: "Missing authorization header");
        }
    }
}