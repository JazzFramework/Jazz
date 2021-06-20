import Server;

public class ImpossibleWeatherErrorTranslator: ErrorTranslator {
    public override func CanHandle(error: Error) -> Bool {
        if case WeatherErrors.impossible = error {
            return true;
        }

        return false;
    }

    public override func Handle(error: Error) -> ResultContext {
        return ResultContextBuilder()
            .With(body: ApiError())
            .With(statusCode: 400)
            .Build();
    }
}