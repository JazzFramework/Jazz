public class ServerAppBuilder {
    private var _httpProcessor: HttpProcessor? = nil;

    public init() {}

    public func with(httpProcessor: HttpProcessor) -> ServerAppBuilder {
        _httpProcessor = httpProcessor;

        return self;
    }

    public func build() throws -> ServerApp {
        if let httpProcessor = _httpProcessor {
            return ServerApp(with: httpProcessor);
        }

        throw ServerAppBuilderError.invalidBuilderState;
    }
}