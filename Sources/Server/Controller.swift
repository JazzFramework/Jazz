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
            .With(statusCode: 204)
            .Build();
    }

    public func Ok(body: Any) -> ResultContext {
        return ResultContextBuilder()
            .With(statusCode: 200)
            .With(body: body)
            .Build();
    }

    public func NoContent() -> ResultContext {
        return ResultContextBuilder()
            .With(statusCode: 204)
            .Build();
    }
}