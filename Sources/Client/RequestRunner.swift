import Foundation;

import Codec;
import Server;

public final class RequestRunner {
    private var _url: URL? = nil;
    private var _method: HttpMethod = .get;
    private var _encoding: String.Encoding = String.Encoding.utf8;
    private var _body: Any? = nil;
    private var _acceptTypes: [MediaType] = [];

    public init() {}

    public func For(url: URL) -> RequestRunner {
        _url = url;

        return self;
    }

    public func For(method: HttpMethod) -> RequestRunner {
        _method = method;

        return self;
    }

    public func For(encoding: String.Encoding) -> RequestRunner {
        _encoding = encoding;

        return self;
    }

    public func For(body: Any) -> RequestRunner {
        _body = body;

        return self;
    }

    public func For(acceptType: MediaType) -> RequestRunner {
        _acceptTypes.append(acceptType);

        return self;
    }

    public func Run() throws -> ProcessableResponse {
        return ProcessableResponse();
    }
}

public final class Weather {}

public final class ExampleClient {
    private static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "weather.weather",
                "version": "1"
            ]
        );

    private let _host: String = "localhost"

    public func CreateWeather() throws -> Weather {
        return try ResponseProcessor()
            .ProcessResponse(
                try RequestRunner()
                    .For(url:
                        try UrlBuilder()
                            .With(host: _host)
                            .With(path: "v1")
                            .With(path: "weathers")
                            .Build()
                    )
                    .For(body: Weather())
                    .For(method: .post)
                    .For(acceptType: ExampleClient.SupportedMediaType)
                    .Run()
            );
    }
}