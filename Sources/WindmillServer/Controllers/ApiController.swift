open class ApiController: Controller {
    public override init() {
        super.init();
    }

    public final func ok(body: Any) -> ResultContext {
        return ResultContextBuilder()
            .with(statusCode: 200)
            .with(body: body)
            .build();
    }

    public final func noContent() -> ResultContext {
        return ResultContextBuilder()
            .with(statusCode: 204)
            .build();
    }
}