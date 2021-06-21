public class NotAcceptableErrorTranslator: ErrorTranslator {
    public override func CanHandle(error: Error) -> Bool {
        if case HttpErrors.notAcceptable = error {
            return true;
        }

        return false
    }

    public override func Handle(error: Error) -> ResultContext {
        return ResultContextBuilder()
            .With(body: ApiError())
            .With(statusCode: 406)
            .Build();
    }
}