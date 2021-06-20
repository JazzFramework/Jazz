import Server;

public class Weather2Controller: Controller {
    private let _action: GetWeatherAction;

    public init(with action: GetWeatherAction) {
        _action = action;
    }

    public override func GetMethod() -> HttpMethod {
        return .get;
    }

    public override func GetRoute() -> String {
        return "/this";
    }

    public override func Logic(withRequest request: RequestContext) throws -> ResultContext {
        let weather: Weather = try _action.GetWeather();

        return ResultContextBuilder()
            .With(statusCode: 200)
            .With(body: weather)
            .Build();
    }
}