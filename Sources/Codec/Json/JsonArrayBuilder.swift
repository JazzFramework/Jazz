public class JsonArrayBuilder {
    private var _data: [JsonTokenable];

    public init() {
        _data = [];
    }

    public func With(_ data: JsonTokenable) -> JsonArrayBuilder {
        _data.append(data);

        return self;
    }

    public func Build() -> JsonArray {
        return JsonArray(withData: _data);
    }
}