public class JsonArray: JsonToken {
    private var data: [JsonToken];

    internal init(withData data: [JsonToken]) {
        self.data = data;
    }

    public subscript(index: Int) -> JsonToken? {
        get {
            return data[index];
        }
    }

    public func getCount() -> Int {
        return data.count;
    }
}