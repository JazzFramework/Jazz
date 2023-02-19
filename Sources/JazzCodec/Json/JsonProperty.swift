public final class JsonProperty: JsonToken {
    private let data: String;

    public static let Empty: JsonProperty =
        JsonProperty(withData: "");

    public init(withData data: String) {
        self.data = data;
    }

    public init(withData data: Int) {
        self.data = "\(data)";
    }

    public init(withData data: Bool) {
        self.data = "\(data)";
    }

    public final func isEmpty() -> Bool {
        return data == "";
    }

    public final func getString() -> String {
        return data;
    }

    public final func getInteger() -> Int? {
        return getValue() { value in
            return Int(value)
        }
    }

    public final func getUnsignedInteger() -> UInt? {
        return getValue() { value in
            return UInt(value)
        }
    }

    public final func getDouble() -> Double? {
        return getValue() { value in
            return Double(value)
        }
    }

    public final func getBool() -> Bool? {
        return getValue() { value in
            return Bool(value)
        }
    }

    public final func getValue<TType>(_ logic: (String) -> TType?) -> TType? {
        return logic(data);
    }
}