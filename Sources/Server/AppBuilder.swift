public class AppBuilder {
    private var _httpProcessor: HttpProcessor? = nil;

    public init() {}

    public func With(httpProcessor: HttpProcessor) -> AppBuilder {
        _httpProcessor = httpProcessor;

        return self;
    }

    public func Build() throws -> App {
        if let httpProcessor = _httpProcessor {
            return App(with: httpProcessor);
        }

        throw AppBuilderError.invalidBuilderState;
    }
}