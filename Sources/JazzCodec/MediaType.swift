import Foundation;

public struct MediaType : CustomStringConvertible, Equatable {
    private let type: String;
    private let subtype: String;

    private let parameter: [String:String];

    public init(
        withType type: String,
        withSubtype subtype: String
    ) {
        self.type = type;
        self.subtype = subtype;
        self.parameter = [:];
    }

    public init(
        withType type: String,
        withSubtype subtype: String,
        withParameters parameters: [String:String]
    ) {
        self.type = type;
        self.subtype = subtype;
        self.parameter = parameters;
    }

    public init(parseFrom value: String) {
        let typeData = value.components(separatedBy: ";")[0].components(separatedBy: "/");

        var parameters: [String: String] = [:];

        for parameter in value.components(separatedBy: ";")[1...] {
            let trimmed = parameter.trimmingCharacters(in: .whitespacesAndNewlines);

            let parameterData = trimmed.components(separatedBy: "=");

            parameters[parameterData[0]] = parameterData[1];
        }

        self.type = typeData[0];
        self.subtype = typeData[1];
        self.parameter = parameters;
    }

    public func getType() -> String {
        return type;
    }

    public func getSubType() -> String {
        return subtype;
    }

    public func getParameter(for key: String) -> String? {
        return parameter[key];
    }

    public var description: String {
        var parameters: [String] = [];

        let sortedKeys = Array(parameter.keys).sorted(by: <)

        for key in sortedKeys {
            if let value = parameter[key] {
                parameters.append("\(key)=\(value)");
            }
        }

        return "\(type)/\(subtype) \(parameters.joined(separator: "; "))";
    }

    static public func == (lhs: MediaType, rhs: MediaType) -> Bool {
        let str1 = String(describing: lhs);
        let str2 = String(describing: rhs);

        return str1.caseInsensitiveCompare(str2) == ComparisonResult.orderedSame;
    }
}