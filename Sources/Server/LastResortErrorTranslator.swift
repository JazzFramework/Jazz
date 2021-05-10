public class LastResortErrorTranslator: ErrorTranslator {
    public override func CanHandle(error: Error) -> Bool {
        return true;
    }

    public override func Handle(error: Error) -> ResultContext {
        return ResultContextBuilder()
            .With(body: ApiError())
            .With(statusCode: 500)
            .Build();
    }
}