import Server;

public class GetWeatherCollectionController: Controller {
    private let _action: GetWeathersAction;

    public init(with action: GetWeathersAction) {
        _action = action;
    }

    public override func GetMethod() -> HttpMethod {
        return .get;
    }

    public override func GetRoute() -> String {
        return "/weather";
    }

    public override func Logic(withRequest request: RequestContext) throws -> ResultContext {
        let weathers: [Weather] = try _action.Get();

        return Ok(body: weathers);
    }
}