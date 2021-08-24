open class ErrorTranslator {
    public init() {}

    open func CanHandle(error: Error) -> Bool {
        return false;
    }

    open func Handle(error: Error) -> ApiError {
        return BuildUnknownError();
    }

    public final func BuildUnknownError() -> ApiError {
        return ApiError(
            withCode: 500,
            withTitle: "Unknown Error",
            withDetails: "Unknown Error",
            withMetadata: [:]
        );
    }
}