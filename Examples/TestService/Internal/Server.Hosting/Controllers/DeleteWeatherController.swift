import Server;

import ExampleServer;

public class DeleteWeatherController: Controller {
    private let _action: DeleteWeather;

    public init(with action: DeleteWeather) {
        _action = action;
    }

    public override func GetMethod() -> HttpMethod {
        return .delete;
    }

    public override func GetRoute() -> String {
        return "/weather/:id";
    }

    public override func Logic(withRequest request: RequestContext) throws -> ResultContext {
        let weatherId: String = request.GetRouteParameter(key: "id");

        try _action.Delete(weatherId: weatherId);

        return NoContent();
    }
}