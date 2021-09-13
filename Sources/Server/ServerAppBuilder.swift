public class ServerAppBuilder {
    private var _httpProcessor: HttpProcessor? = nil;

    public init() {}

    public func With(httpProcessor: HttpProcessor) -> ServerAppBuilder {
        _httpProcessor = httpProcessor;

        return self;
    }

    public func Build() throws -> ServerApp {
        if let httpProcessor = _httpProcessor {
            return ServerApp(with: httpProcessor);
        }

        throw ServerAppBuilderError.invalidBuilderState;
    }
}