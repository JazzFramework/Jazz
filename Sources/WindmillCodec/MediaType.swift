import Foundation;

public struct MediaType : CustomStringConvertible, Equatable {
    private let _type: String;
    private let _subtype: String;

    private let _parameter: [String:String];

    public init(
        withType type: String,
        withSubtype subtype: String
    ) {
        _type = type;
        _subtype = subtype;
        _parameter = [:];
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

    public init(parseFrom value: String) {
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

    public func getType() -> String {
        return _type;
    }

    public func getSubType() -> String {
        return _subtype;
    }

    public func getParameter(for key: String) -> String? {
        return _parameter[key];
    }

    public var description: String {
        var parameters: [String] = [];

        let sortedKeys = Array(_parameter.keys).sorted(by: <)

        for key in sortedKeys {
            if let value = _parameter[key] {
                parameters.append("\(key)=\(value)");
            }
        }

        return "\(_type)/\(_subtype) \(parameters.joined(separator: "; "))";
    }

    static public func == (lhs: MediaType, rhs: MediaType) -> Bool {
        let str1 = String(describing: lhs);
        let str2 = String(describing: rhs);

        return str1.caseInsensitiveCompare(str2) == ComparisonResult.orderedSame;
    }
}