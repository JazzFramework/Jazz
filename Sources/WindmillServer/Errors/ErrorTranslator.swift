open class ErrorTranslator {
    public init() {}

    open func canHandle(error: Error) -> Bool {
        return false;
    }

    open func translate(error: Error) -> ApiError {
        return buildUnknownError();
    }

    public final func buildUnknownError() -> ApiError {
        return ApiError(
            withCode: 500,
            withTitle: "Unknown Error",
            withDetails: "Unknown Error",
            withMetadata: [:]
        );
    }
}