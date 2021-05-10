public struct MediaType : CustomStringConvertible {
    private let _type: String;
    private let _subtype: String;

    private let _parameter: [String:String];

    public var description: String {
        var parameters: [String] = [];

        for (key, value) in _parameter {
            parameters.append("\(key)=\(value)")
        }

        return "\(_type)/\(_subtype) \(parameters.joined(separator: "; "))";
    }

    public init(
        withType type: String,
        withSubtype subtype: String,
        withParameters parameters: [String:String]
    ) {
        _type = type;
        _subtype = subtype;
        _parameter = parameters;
    }

    public func GetType() -> String {
        return _type;
    }

    public func GetSubType() -> String {
        return _subtype;
    }

    public func GetParameter(for key: String) -> String? {
        return _parameter[key];
    }
}