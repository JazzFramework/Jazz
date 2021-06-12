public class JsonObjectBuilder {
    private var _data: [String: JsonTokenable];

    public init() {
        _data = [:];
    }

    public func With(_ key: String, property: JsonProperty) -> JsonObjectBuilder {
        _data[key] = property;

        return self;
    }

    public func With(_ key: String, object: JsonObject) -> JsonObjectBuilder {
        _data[key] = object;

        return self;
    }

    public func With(_ key: String, array: JsonArray) -> JsonObjectBuilder {
        _data[key] = array;

        return self;
    }

    public func Build() -> JsonObject {
        return JsonObject(withData: _data);
    }
}