public class JsonArray: JsonToken {
    private var _data: [JsonToken];

    internal init(withData data: [JsonToken]) {
        _data = data;
    }

    public subscript(index: Int) -> JsonToken? {
        get {
            return _data[index];
        }
    }

    public func GetCount() -> Int {
        return _data.count;
    }
}