/*
enum HttpErrors: Error {
    case notAcceptable
}
*/

public class NotAcceptableErrorTranslator: ErrorTranslator {
    public override func CanHandle(error: Error) -> Bool {
        //return error is HttpErrors.notAcceptable;
        return false
    }

    public override func Handle(error: Error) -> ResultContext {
        return ResultContextBuilder()
            .With(body: ApiError())
            .With(statusCode: 406)
            .Build();
    }
}