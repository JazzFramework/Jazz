public class LastResortErrorTranslator: ErrorTranslator {
    public override func CanHandle(error: Error) -> Bool {
        return true;
    }

    public override func Handle(error: Error) -> ApiError {
        return ApiError(
            withCode: 500,
            withTitle: "Unknown Error",
            withDetails: "Unknown Error",
            withMetadata: [:]
        );
    }
}