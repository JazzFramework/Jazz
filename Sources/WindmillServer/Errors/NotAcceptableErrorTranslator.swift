internal final class NotAcceptableErrorTranslator: ErrorTranslator {
    public override func canHandle(error: Error) -> Bool {
        if case HttpErrors.notAcceptable = error {
            return true;
        }

        return false
    }

    public override func translate(error: Error) -> ApiError {
        return ApiError(
            withCode: 406,
            withTitle: "UnsupportedMediaType",
            withDetails: "UnsupportedMediaType",
            withMetadata: [:]
        );
    }
}