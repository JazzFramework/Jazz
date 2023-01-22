open class ErrorTranslator {
    public init() {}

    open func canHandle(error: Error) -> Bool {
        return false;
    }

    open func translate(error: Error) -> ServerError {
        return buildUnknownError();
    }

    public final func buildUnknownError() -> ServerError {
        return ServerErrorBuilder()
            .with(code: 500)
            .with(title: "Unknown Error")
            .with(details: "Unknown Error")
            .build();
    }
}