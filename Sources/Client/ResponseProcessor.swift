public final class ResponseProcessor<TResult> {
    public init() {}

    public func Ensure(statusCode: Int) -> ResponseProcessor<TResult> {
        return self;
    }

    public func Process(response: ProcessableResponse) throws -> TResult {
        throw UrlErrors.couldNotBuild(reason: "UrlBuilder is in an invalid state.");
    }
}