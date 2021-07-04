import Server;

public class Weather2Controller: Controller {
    private let _action: GetWeatherAction;

    public init(with action: GetWeatherAction) {
        _action = action;
    }

    public override func GetRoute() -> String {
        return "/this";
    }

    public override func Logic(withRequest request: RequestContext) throws -> ResultContext {
        return ResultContextBuilder()
            .With(statusCode: 200)
            .With(body: try _action.GetWeather())
            .Build();
    }
}