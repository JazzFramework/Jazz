public class JsonProperty: JsonToken {
    private let _data: String;

    public init(withData data: String) {
        _data = data;
    }

    public init(withData data: Int) {
        _data = "\(data)";
    }

    public func GetString() -> String {
        return _data;
    }

    public func GetInteger() -> Int? {
        return GetValue() { value in
            return Int(value)
        }
    }

    public func GetUnsignedInteger() -> UInt? {
        return GetValue() { value in
            return UInt(value)
        }
    }

    public func GetDouble() -> Double? {
        return GetValue() { value in
            return Double(value)
        }
    }

    public func GetBool() -> Bool? {
        return GetValue() { value in
            return Bool(value)
        }
    }

    public func GetValue<TType>(_ logic: (String) -> TType?) -> TType? {
        return logic(_data);
    }
}