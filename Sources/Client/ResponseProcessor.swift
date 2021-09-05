public final class ResponseProcessor<TResult> {
    public func ProcessResponse(_ response: ProcessableResponse) throws -> TResult {
        throw UrlErrors.couldNotBuild(reason: "UrlBuilder is in an invalid state.");
    }
}