internal final class NotAuthenticatedErrorTranslator: ErrorTranslator {
    public override func canHandle(error: Error) -> Bool {
        if case HttpErrors.notAuthenticated = error {
            return true;
        }

        return false
    }

    public override func translate(error: Error) -> ServerError {
        return ServerErrorBuilder()
            .with(code: 403)
            .with(title: "Not Authenticated")
            .with(details: "Not Authenticated")
            .build();
    }
}