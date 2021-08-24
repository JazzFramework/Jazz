internal final class MissingBodyErrorTranslator: ErrorTranslator {
    public override func CanHandle(error: Error) -> Bool {
        if case ControllerErrors.missingBody = error {
            return true;
        }

        return false
    }

    public override func Handle(error: Error) -> ApiError {
        return ApiError(
            withCode: 400,
            withTitle: "MissingBody",
            withDetails: "MissingBody",
            withMetadata: [:]
        );
    }
}