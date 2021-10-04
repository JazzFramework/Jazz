public class JsonObject: JsonToken {
    private var data: [String: JsonToken];

    internal init(withData data: [String: JsonToken]) {
        self.data = data;
    }

    public subscript(key: String) -> JsonToken? {
        get {
            return data[key];
        }
    }

    public func getKeys() -> Set<String> {
        return Set<String>(data.keys);
    }
}