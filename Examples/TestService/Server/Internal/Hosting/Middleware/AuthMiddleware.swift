import Server;

import ExampleServer;

public class AuthMiddleware: Middleware {
    public final override func Logic(
        for request: RequestContext,
        with next: (RequestContext) throws -> ResultContext
    ) throws -> ResultContext {
        var isAuthorized: Bool = false;

        let authorization = request.GetHeaders(key: "Authorization");

        if authorization.count > 0 && authorization[0] != "" {
            isAuthorized = true;
        }

        if !isAuthorized {
            throw AuthErrors.notAuthorized(reason: "Missing authorization header");
        }

        return try next(request);
    }
}