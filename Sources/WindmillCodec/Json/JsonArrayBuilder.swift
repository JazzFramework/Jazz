public class JsonArrayBuilder {
    private var data: [JsonToken];

    public init() {
        data = [];
    }

    public func with(_ data: JsonToken) -> JsonArrayBuilder {
        self.data.append(data);

        return self;
    }

    public func build() -> JsonArray {
        return JsonArray(withData: data);
    }
}