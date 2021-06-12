import Server;

public class Weather3Controller: Controller {
    public override init() {
        super.init();
    }

    public override func GetMethod() -> HttpMethod {
        return HttpMethod.get;
    }

    public override func GetRoute() -> String {
        return "/this/this";
    }

    public override func Logic(withRequest request: RequestContext) throws -> ResultContext {
        return ResultContextBuilder()
            .With(statusCode: 200)
            .With(body: Weather("3"))
            .Build();
    }
}