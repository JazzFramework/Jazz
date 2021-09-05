import Foundation;

public final class UrlBuilder {
    private var _scheme: String = "https";
    private var _host: String = "";
    private var _path: [String] = [];
    private var _queryString: [String:String] = [:];

    public init() {}

    public func With(scheme: String) -> UrlBuilder {
        _scheme = scheme;

        return self;
    }

    public func With(host: String) -> UrlBuilder {
        _host = host;

        return self;
    }

    public func With(path: String) -> UrlBuilder {
        _path.append(path);

        return self;
    }

    public func With(query: String, value: String) -> UrlBuilder {
        _queryString[query] = value;

        return self;
    }

    public func Build() throws -> URL {
        var components: URLComponents = URLComponents();

        components.scheme = _scheme;
        components.host = _host;
        components.path = _path.joined(separator: "/");
        components.queryItems = _queryString.map{ URLQueryItem(name: $0, value: $1) };

        if let url: URL = components.url {
            return url;
        }

        throw UrlErrors.couldNotBuild(reason: "UrlBuilder is in an invalid state.");
    }
}