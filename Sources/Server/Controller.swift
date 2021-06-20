open class Controller {
    public init() {}

    open func GetMethod() -> HttpMethod {
        return .get;
    }

    open func GetRoute() -> String {
        return "/";
    }

    open func Logic(withRequest request: RequestContext) throws -> ResultContext {
        return ResultContextBuilder()
            .With(statusCode: 200)
            .Build();
    }
}