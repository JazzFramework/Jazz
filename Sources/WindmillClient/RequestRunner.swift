import Foundation;

import WindmillCodec;
import WindmillServer;

public final class RequestRunner {
    private var _url: URL? = nil;
    private var _method: HttpMethod = .get;
    private var _encoding: String.Encoding = String.Encoding.utf8;
    private var _body: Any? = nil;
    private var _acceptTypes: [MediaType] = [];
    private var _headers: [String:[String]] = [:];

    public init() {}

    public func with(url: URL) -> RequestRunner {
        _url = url;

        return self;
    }

    public func with(method: HttpMethod) -> RequestRunner {
        _method = method;

        return self;
    }

    public func with(encoding: String.Encoding) -> RequestRunner {
        _encoding = encoding;

        return self;
    }

    public func with(body: Any) -> RequestRunner {
        _body = body;

        return self;
    }

    public func with(acceptType: MediaType) -> RequestRunner {
        _acceptTypes.append(acceptType);

        return self;
    }

    public func with(header: String, values: [String]) -> RequestRunner {
        _headers[header] = values;

        return self;
    }

    public func run() throws -> ProcessableResponse {
        return ProcessableResponse();
    }
}