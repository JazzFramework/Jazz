import Codec;

public protocol HttpProcessor {
    func WireUp(controller: Controller) -> HttpProcessor;

    func WireUp(errorTranslator: ErrorTranslator) -> HttpProcessor;

    func WireUp(middleware: Middleware) -> HttpProcessor;

    func WireUp(transcoder: Transcoder) -> HttpProcessor;

    func Start() async throws;
}