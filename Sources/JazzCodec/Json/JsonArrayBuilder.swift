public final class JsonArrayBuilder {
    private var data: [JsonToken];

    public init() {
        data = [];
    }

    public final func with(_ data: JsonToken) -> JsonArrayBuilder {
        self.data.append(data);

        return self;
    }

    public final func build() -> JsonArray {
        return JsonArray(withData: data);
    }
}