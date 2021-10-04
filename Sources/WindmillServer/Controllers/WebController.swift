open class WebController: Controller {
    public override init() {
        super.init();
    }

    public final func template(_ template: String, _ data: Any...) -> ResultContext {
        return ResultContextBuilder()
            .with(statusCode: 200)
            .build();
    }
}