internal final class NotAuthorizedErrorTranslator: ErrorTranslator {
    public override func canHandle(error: Error) -> Bool {
        if case HttpErrors.notAuthorized = error {
            return true;
        }

        return false
    }

    public override func translate(error: Error) -> ServerError {
        return ServerErrorBuilder()
            .with(code: 401)
            .with(title: "Not Authorized")
            .with(details: "Not Authorized")
            .build();
    }
}