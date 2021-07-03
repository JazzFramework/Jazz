open class ErrorTranslator {
    public init() {}

    open func CanHandle(error: Error) -> Bool {
        return false;
    }

    open func Handle(error: Error) -> ResultContext {
        return ResultContextBuilder()
            .With(statusCode: 500)
            .Build();
    }
}