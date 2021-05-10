import Codec;

public protocol HttpProcessor {
    func WireUp(controller: Controller) -> HttpProcessor;

    func WireUp(errorTranslator: ErrorTranslator) -> HttpProcessor;

    func WireUp(middleware: Middleware) -> HttpProcessor;

    func WireUp(encoder: Encoder) -> HttpProcessor;

    func WireUp(decoder: Decoder) -> HttpProcessor;

    func Start() throws;
}