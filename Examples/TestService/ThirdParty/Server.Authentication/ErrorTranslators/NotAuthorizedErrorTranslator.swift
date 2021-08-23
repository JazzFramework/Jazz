import Server;

internal final class NotAuthorizedErrorTranslator: ErrorTranslator {
    public override func CanHandle(error: Error) -> Bool {
        if case AuthErrors.notAuthorized = error {
            return true;
        }

        return false;
    }

    public override func Handle(error: Error) -> ApiError {
        switch(error) {
            case AuthErrors.notAuthorized(let reason):
                return ApiError(
                    withCode: 401,
                    withTitle: "Not Authorized",
                    withDetails: "\(reason)",
                    withMetadata: [
                        "reason": reason
                    ]
                );

            default:
                return BuildUnknownError();
        }
    }
}