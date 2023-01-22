public final class ServerErrorBuilder {
    private var code: UInt;
    private var title: String;
    private var details: String;
    private var metadata: [String: String];

    public init() {
        self.code = 0;
        self.title = "";
        self.details = "";
        self.metadata = [:];
    }

    public final func with(code: UInt) -> ServerErrorBuilder {
        self.code = code;

        return self;
    }

    public final func with(title: String) -> ServerErrorBuilder {
        self.title = title;

        return self;
    }

    public final func with(details: String) -> ServerErrorBuilder {
        self.details = details;

        return self;
    }

    public final func with(metadataKey: String, metadataValue: String) -> ServerErrorBuilder {
        self.metadata[metadataKey] = metadataValue;

        return self;
    }

    public final func with(metadata: [String:String]) -> ServerErrorBuilder {
        for (key, value) in metadata {
            _ = with(metadataKey: key, metadataValue: value);
        }

        return self;
    }

    public final func build() -> ServerError {
        return ServerError(withCode: code, withTitle: title, withDetails: details, withMetadata: metadata);
    }
}