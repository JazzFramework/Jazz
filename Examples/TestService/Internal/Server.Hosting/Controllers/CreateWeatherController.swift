import Configuration;
import Server;

import ExampleServer;
import ExampleCommon;

public class CreateWeatherController: Controller {
    private let _action: CreateWeather;
    private let _config: Configuration;

    public init(with config: Configuration, with action: CreateWeather) {
        _action = action;
        _config = config;
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
        if let appConfig: AppConfig = _config.Fetch() {
            print(appConfig.Setting);
        }

        guard let weather: Weather = try request.GetBody() else {
            throw ControllerErrors.missingBody;
        }

        return weather;
    }
}