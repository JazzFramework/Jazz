import NIO
import NIOHTTP1

import Codec;
import Server;

public class NioHttpProcessor: HttpProcessor {
    private let _defaultHost = "127.0.0.1";
    private let _defaultPort = 8080;

    //private let _handler = HttpHandlers();

    public init() {
    }

    public func WireUp(controller: Controller) -> HttpProcessor {
        return self;
    }

    public func WireUp(errorTranslator: ErrorTranslator) -> HttpProcessor {
        return self;
    }

    public func WireUp(middleware: Middleware) -> HttpProcessor {
        return self;
    }

    public func WireUp(encoder: Encoder) -> HttpProcessor {
        return self;
    }

    public func WireUp(decoder: Decoder) -> HttpProcessor {
        return self;
    }

    public func Start() throws {
    }
}