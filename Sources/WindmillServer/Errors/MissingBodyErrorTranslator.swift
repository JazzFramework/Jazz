internal final class MissingBodyErrorTranslator: ErrorTranslator {
    public override func canHandle(error: Error) -> Bool {
        if case ControllerErrors.missingBody = error {
            return true;
        }

        return false
    }

    public override func translate(error: Error) -> ApiError {
        return ApiError(
            withCode: 400,
            withTitle: "MissingBody",
            withDetails: "MissingBody",
            withMetadata: [:]
        );
    }
}