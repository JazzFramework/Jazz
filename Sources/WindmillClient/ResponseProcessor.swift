public final class ResponseProcessor<TResult> {
    public init() {}

    public func ensure(statusCode: Int) -> ResponseProcessor<TResult> {
        return self;
    }

    public func process(response: ProcessableResponse) throws -> TResult {
        throw UrlErrors.couldNotBuild(reason: "UrlBuilder is in an invalid state.");
    }
}