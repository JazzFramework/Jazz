public final class ResponseProcessor<TResult> {
    public init() {}

    public final func ensure(statusCode: Int) -> ResponseProcessor<TResult> {
        return self;
    }

    public final func process(response: ProcessableResponse) throws -> TResult {
        throw UrlErrors.couldNotBuild(reason: "UrlBuilder is in an invalid state.");
    }
}