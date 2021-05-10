import Server;

public class WeatherController: Controller {
    public override init() {
        super.init();
    }

    public override func GetMethod() -> HttpMethod {
        return HttpMethod.get;
    }

    public override func GetRoute() -> String {
        return "/";
    }

    public override func Logic(withRequest request: RequestContext) throws -> ResultContext {
        return ResultContextBuilder()
            .With(statusCode: 200)
            .Build();
    }
}