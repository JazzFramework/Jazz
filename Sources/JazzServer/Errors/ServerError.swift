public final class ServerError {
    private final let code: UInt;
    private final let title: String;
    private final let details: String;
    private final let metadata: [String: String];

    internal init(
        withCode code: UInt,
        withTitle title: String,
        withDetails details: String,
        withMetadata metadata: [String: String]
    )
    {
        self.code = code;
        self.title = title;
        self.details = details;
        self.metadata = metadata;
    }

    public final func getCode() -> UInt {
        return code;
    }

    public final func getTitle() -> String {
        return title;
    }

    public final func getDetails() -> String {
        return details;
    }

    public final func getMetadata() -> [String: String] {
        return metadata;
    }
}