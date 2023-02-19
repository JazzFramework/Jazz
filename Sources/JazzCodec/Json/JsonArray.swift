public final class JsonArray: JsonToken {
    private var data: [JsonToken];

    internal init(withData data: [JsonToken]) {
        self.data = data;
    }

    public final subscript(index: Int) -> JsonToken? {
        get {
            return data[index];
        }
    }

    public final func getCount() -> Int {
        return data.count;
    }
}