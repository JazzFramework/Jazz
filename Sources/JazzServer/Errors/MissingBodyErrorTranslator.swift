internal final class MissingBodyErrorTranslator: ErrorTranslator {
    public override func canHandle(error: Error) -> Bool {
        if case ControllerErrors.missingBody = error {
            return true;
        }

        return false
    }

    public override func translate(error: Error) -> ServerError {
        return ServerErrorBuilder()
            .with(code: 400)
            .with(title: "Missing Body")
            .with(details: "Missing Body")
            .build();
    }
}