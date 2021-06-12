public class JsonArray: JsonTokenable {
    private var _data: [JsonTokenable];

    internal init(withData data: [JsonTokenable]) {
        _data = data;
    }

    subscript(index: Int) -> JsonTokenable? {
        get {
            return _data[index];
        }
    }

    public func GetCount() -> Int {
        return _data.count;
    }
}