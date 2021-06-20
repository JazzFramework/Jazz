import Server;

public class Weather3Controller: Controller {
    public override func GetMethod() -> HttpMethod {
        return .get;
    }

    public override func GetRoute() -> String {
        return "/this/this";
    }

    public override func Logic(withRequest request: RequestContext) throws -> ResultContext {
        throw WeatherErrors.impossible;
    }
}