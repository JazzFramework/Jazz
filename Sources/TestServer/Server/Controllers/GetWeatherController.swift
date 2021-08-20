import Server;

public class GetWeatherController: Controller {
    private let _action: GetWeatherAction;

    public init(with action: GetWeatherAction) {
        _action = action;
    }

    public override func GetMethod() -> HttpMethod {
        return .get;
    }

    public override func GetRoute() -> String {
        return "/weather/:id";
    }

    public override func Logic(withRequest request: RequestContext) throws -> ResultContext {
        let weatherId: String = request.GetRouteParameter(key: "id");

        let weather: Weather = try _action.Get(weatherId: weatherId);

        return Ok(body: weather);
    }
}