public class ApiError {
    private let _code: UInt;
    private let _title: String;
    private let _details: String;
    private let _metadata: [String: String];

    public init(
        withCode code: UInt,
        withTitle title: String,
        withDetails details: String,
        withMetadata metadata: [String: String]
    )
    {
        _code = code;
        _title = title;
        _details = details;
        _metadata = metadata;
    }

    public func getCode() -> UInt {
        return _code;
    }

    public func getTitle() -> String {
        return _title;
    }

    public func getDetails() -> String {
        return _details;
    }

    public func getMetadata() -> [String: String] {
        return _metadata;
    }
}