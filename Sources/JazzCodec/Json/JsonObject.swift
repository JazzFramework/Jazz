public final class JsonObject: JsonToken {
    private var data: [String: JsonToken];

    internal init(withData data: [String: JsonToken]) {
        self.data = data;
    }

    public final subscript(key: String) -> JsonToken? {
        get {
            return data[key];
        }
    }

    public final func getKeys() -> Set<String> {
        return Set<String>(data.keys);
    }
}