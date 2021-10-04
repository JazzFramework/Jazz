open class Controller {
    public init() {}

    open func getMethod() -> HttpMethod {
        return .get;
    }

    open func getRoute() -> String {
        return "/";
    }

    open func logic(withRequest request: RequestContext) async throws -> ResultContext {
        return ResultContextBuilder()
            .with(statusCode: 204)
            .build();
    }
}