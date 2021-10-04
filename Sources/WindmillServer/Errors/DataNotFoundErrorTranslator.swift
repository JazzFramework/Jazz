import WindmillDataAccess;

internal final class DataNotFoundErrorTranslator: ErrorTranslator {
    public override func canHandle(error: Error) -> Bool {
        if case DataAccessErrors.notFound = error {
            return true;
        }

        return false;
    }

    public override func translate(error: Error) -> ApiError {
        switch(error) {
            case DataAccessErrors.notFound(let reason):
                return ApiError(
                    withCode: 404,
                    withTitle: "Resource not found",
                    withDetails: "\(reason)",
                    withMetadata: [
                        "reason": reason
                    ]
                );

            default:
                return buildUnknownError();
        }
    }
}