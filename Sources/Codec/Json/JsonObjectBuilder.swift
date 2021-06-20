public class JsonObjectBuilder {
    private var _data: [String: JsonToken];

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

    public func With(_ key: String, token: JsonToken) -> JsonObjectBuilder {
        _data[key] = token;

        return self;
    }

    public func Build() -> JsonObject {
        return JsonObject(withData: _data);
    }
}