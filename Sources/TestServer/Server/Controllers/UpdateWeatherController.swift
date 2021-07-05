import Server;

public class UpdateWeatherController: Controller {
    private let _action: UpdateWeatherAction;

    public init(with action: UpdateWeatherAction) {
        _action = action;
    }

    public override func GetMethod() -> HttpMethod {
        return .put;
    }

    public override func GetRoute() -> String {
        return "/weather";
    }

    public override func Logic(withRequest request: RequestContext) throws -> ResultContext {
        let weather: Weather = try _action.Update(weather: try GetWeather(request));

        return Ok(body: weather);
    }

    private func GetWeather(_ request: RequestContext) throws -> Weather {
        guard let weather: Weather = try request.GetBody() else {
            throw ControllerErrors.missingBody;
        }

        return weather;
    }
}