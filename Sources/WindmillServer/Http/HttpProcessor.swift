import WindmillCodec;

public protocol HttpProcessor {
    func wireUp(controller: Controller) -> HttpProcessor;

    func wireUp(errorTranslator: ErrorTranslator) -> HttpProcessor;

    func wireUp(middleware: Middleware) -> HttpProcessor;

    func wireUp(transcoder: Transcoder) -> HttpProcessor;

    func start() async throws;
}