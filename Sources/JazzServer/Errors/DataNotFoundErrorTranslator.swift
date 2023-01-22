import JazzDataAccess;

internal final class DataNotFoundErrorTranslator: ErrorTranslator {
    public override func canHandle(error: Error) -> Bool {
        if case DataAccessErrors.notFound = error {
            return true;
        }

        return false;
    }

    public override func translate(error: Error) -> ServerError {
        switch(error) {
            case DataAccessErrors.notFound(let reason):
                return ServerErrorBuilder()
                    .with(code: 404)
                    .with(title: "Resource not found")
                    .with(details: "\(reason)")
                    .with(metadataKey: "reason", metadataValue: reason)
                    .build();

            default:
                return buildUnknownError();
        }
    }
}