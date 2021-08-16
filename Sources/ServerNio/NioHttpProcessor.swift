import Foundation;

import Codec;
import Server;

public class NioHttpProcessor: HttpProcessor {
    private var _transcoders: [Transcoder];
    private var _middlewares: [Server.Middleware];
    private var _errorTranslators: [ErrorTranslator];

    public init() {
        _transcoders = [];
        _middlewares = [];
        _errorTranslators = [];
    }

    public func WireUp(controller: Controller) -> HttpProcessor {
        return self;
    }

    public func WireUp(errorTranslator: ErrorTranslator) -> HttpProcessor {
        _errorTranslators.append(errorTranslator);

        return self;
    }

    public func WireUp(middleware: Server.Middleware) -> HttpProcessor {
        _middlewares.append(middleware);

        return self;
    }

    public func WireUp(transcoder: Transcoder) -> HttpProcessor {
        _transcoders.append(transcoder);

        return self;
    }

    public func Start() throws {
    }
}