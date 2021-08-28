import Server;

import ExampleCommon;
import ExampleServer;

public class CreateWeatherController: Controller {
    private let _action: CreateWeather;

    public init(with action: CreateWeather) {
        _action = action;
    }

    public override func GetMethod() -> HttpMethod {
        return .post;
    }

    public override func GetRoute() -> String {
        return "/weather";
    }

    public override func Logic(withRequest request: RequestContext) throws -> ResultContext {
        let weather: Weather = try _action.Create(weather: try GetWeather(request));

        return Ok(body: weather);
    }

    private func GetWeather(_ request: RequestContext) throws -> Weather {
        guard let weather: Weather = try request.GetBody() else {
            throw ControllerErrors.missingBody;
        }

        return weather;
    }
}