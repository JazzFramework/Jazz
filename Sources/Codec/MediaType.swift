public struct MediaType : CustomStringConvertible, Equatable {
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

    public init(
        parseFrom value: String
    ) {
        let typeData = value.components(separatedBy: ";")[0].components(separatedBy: "/");

        var parameters: [String: String] = [:];

        for parameter in value.components(separatedBy: ";")[1...] {
            let trimmed = parameter.trimmingCharacters(in: .whitespacesAndNewlines);

            let parameterData = trimmed.components(separatedBy: "=");

            parameters[parameterData[0]] = parameterData[1];
        }

        _type = typeData[0];
        _subtype = typeData[1];
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

    static public func == (lhs: MediaType, rhs: MediaType) -> Bool {
        return String(describing: lhs) == String(describing: rhs);
    }
}