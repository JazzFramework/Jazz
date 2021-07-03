public class UnsupportedMediaTypeErrorTranslator: ErrorTranslator {
    public override func CanHandle(error: Error) -> Bool {
        if case HttpErrors.unsupportedMediaType = error {
            return true;
        }

        return false
    }

    public override func Handle(error: Error) -> ResultContext {
        return ResultContextBuilder()
            .With(body:
                ApiError(
                    withCode: 415,
                    withTitle: "UnsupportedMediaType",
                    withDetails: "UnsupportedMediaType",
                    withMetadata: [:]
                )
            )
            .With(statusCode: 415)
            .Build();
    }
}