open class Controller {
    public init() {}

    open func getMethod() -> HttpMethod {
        return .get;
    }

    open func getRoute() -> String {
        return "/";
    }

    open func logic(withRequest request: RequestContext, intoResult result: ResultContext) async throws {}
}