import Foundation;

public final class UrlBuilder {
    private var scheme: String = "https";
    private var host: String = "";
    private var port: Int = 80;
    private var path: [String] = [];
    private var queryString: [String:String] = [:];

    public init() {}

    public final func with(scheme: String) -> UrlBuilder {
        self.scheme = scheme;

        return self;
    }

    public final func with(host: String) -> UrlBuilder {
        self.host = host;

        return self;
    }

    public final func with(port: Int) -> UrlBuilder {
        self.port = port;

        return self;
    }

    public final func with(path: String) -> UrlBuilder {
        self.path.append(path);

        return self;
    }

    public final func with(query: String, value: String) -> UrlBuilder {
        self.queryString[query] = value;

        return self;
    }

    public final func build() throws -> URL {
        var components: URLComponents = URLComponents();

        components.scheme = self.scheme;
        components.port = self.port;
        components.host = self.host;
        components.path = self.path.joined(separator: "/");
        components.queryItems = self.queryString.map{ URLQueryItem(name: $0, value: $1) };

        if let url: URL = components.url {
            return url;
        }

        throw UrlErrors.couldNotBuild(reason: "UrlBuilder is in an invalid state.");
    }
}