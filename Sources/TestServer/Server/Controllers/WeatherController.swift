import Server;

public class WeatherController: Controller {
    public override func GetMethod() -> HttpMethod {
        return .post;
    }

    public override func GetRoute() -> String {
        return "/here";
    }

    public override func Logic(withRequest request: RequestContext) throws -> ResultContext {
        return ResultContextBuilder()
            .With(statusCode: 200)
            .With(body: Weather("1"))
            .Build();
    }
}