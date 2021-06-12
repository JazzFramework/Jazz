public class JsonObject: JsonTokenable {
    private var _data: [String: JsonTokenable];

    internal init(withData data: [String: JsonTokenable]) {
        _data = data;
    }

    subscript(key: String) -> JsonTokenable? {
        get {
            return _data[key];
        }
    }

    public func GetKeys() -> Set<String> {
        return Set<String>(_data.keys);
    }
}