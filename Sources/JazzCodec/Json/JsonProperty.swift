public class JsonProperty: JsonToken {
    private let data: String;

    public static let Empty: JsonProperty =
        JsonProperty(withData: "");

    public init(withData data: String) {
        self.data = data;
    }

    public init(withData data: Int) {
        self.data = "\(data)";
    }

    public func getString() -> String {
        return data;
    }

    public func getInteger() -> Int? {
        return getValue() { value in
            return Int(value)
        }
    }

    public func getUnsignedInteger() -> UInt? {
        return getValue() { value in
            return UInt(value)
        }
    }

    public func getDouble() -> Double? {
        return getValue() { value in
            return Double(value)
        }
    }

    public func getBool() -> Bool? {
        return getValue() { value in
            return Bool(value)
        }
    }

    public func getValue<TType>(_ logic: (String) -> TType?) -> TType? {
        return logic(data);
    }
}