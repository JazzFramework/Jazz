public class UnsupportedMediaTypeErrorTranslator: ErrorTranslator {
    public override func CanHandle(error: Error) -> Bool {
        if case HttpErrors.unsupportedMediaType = error {
            return true;
        }

        return false
    }

    public override func Handle(error: Error) -> ApiError {
        return ApiError(
            withCode: 415,
            withTitle: "UnsupportedMediaType",
            withDetails: "UnsupportedMediaType",
            withMetadata: [:]
        );
    }
}