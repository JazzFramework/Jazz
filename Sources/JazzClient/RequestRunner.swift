import Foundation;

import JazzCodec;
import JazzServer;

public final class RequestRunner {
    private var url: URL? = nil;
    private var method: HttpMethod = .get;
    private var encoding: String.Encoding = String.Encoding.utf8;
    private var body: Any? = nil;
    private var acceptTypes: [MediaType] = [];
    private var headers: [String:[String]] = [:];

    public init() {}

    public final func with(url: URL) -> RequestRunner {
        self.url = url;

        return self;
    }

    public final func with(method: HttpMethod) -> RequestRunner {
        self.method = method;

        return self;
    }

    public final func with(encoding: String.Encoding) -> RequestRunner {
        self.encoding = encoding;

        return self;
    }

    public final func with(body: Any) -> RequestRunner {
        self.body = body;

        return self;
    }

    public final func with(acceptType: MediaType) -> RequestRunner {
        self.acceptTypes.append(acceptType);

        return self;
    }

    public final func with(header: String, values: [String]) -> RequestRunner {
        self.headers[header] = values;

        return self;
    }

    public final func run() throws -> ProcessableResponse {
        return ProcessableResponse();
    }
}