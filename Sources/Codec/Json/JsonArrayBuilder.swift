public class JsonArrayBuilder {
    private var _data: [JsonToken];

    public init() {
        _data = [];
    }

    public func With(_ data: JsonToken) -> JsonArrayBuilder {
        _data.append(data);

        return self;
    }

    public func Build() -> JsonArray {
        return JsonArray(withData: _data);
    }
}