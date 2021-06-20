import MicroExpress;

import Codec;
import Server;

public class NioHttpProcessor: HttpProcessor {
    private let _defaultHost = "127.0.0.1";
    private let _defaultPort = 8080;

    private let _app: Express;

    public init() {
        _app = Express();
    }

    public func WireUp(controller: Controller) -> HttpProcessor {
        _app.get(controller.GetRoute()) { _, res, _ in
            let result: ResultContext =
                try! controller.Logic(withRequest: RequestContextBuilder().Build());

            res.send("asdf asdfas Hello World \(controller.GetRoute())");
        }

        return self;
    }

    public func WireUp(errorTranslator: ErrorTranslator) -> HttpProcessor {
        return self;
    }

    public func WireUp(middleware: Server.Middleware) -> HttpProcessor {
        return self;
    }

    public func WireUp(encoder: Encoder) -> HttpProcessor {
        return self;
    }

    public func WireUp(decoder: Decoder) -> HttpProcessor {
        return self;
    }

    public func Start() throws {
        _app.listen(_defaultPort);
    }
}