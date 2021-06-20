public class JsonObject: JsonToken {
    private var _data: [String: JsonToken];

    internal init(withData data: [String: JsonToken]) {
        _data = data;
    }

    public subscript(key: String) -> JsonToken? {
        get {
            return _data[key];
        }
    }

    public func GetKeys() -> Set<String> {
        return Set<String>(_data.keys);
    }
}