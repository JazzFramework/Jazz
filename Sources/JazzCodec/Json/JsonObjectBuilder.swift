public class JsonObjectBuilder {
    private var data: [String: JsonToken];

    public init() {
        data = [:];
    }

    public func with(_ key: String, property: JsonProperty) -> JsonObjectBuilder {
        data[key] = property;

        return self;
    }

    public func with(_ key: String, object: JsonObject) -> JsonObjectBuilder {
        data[key] = object;

        return self;
    }

    public func with(_ key: String, array: JsonArray) -> JsonObjectBuilder {
        data[key] = array;

        return self;
    }

    public func with(_ key: String, token: JsonToken) -> JsonObjectBuilder {
        data[key] = token;

        return self;
    }

    public func build() -> JsonObject {
        return JsonObject(withData: data);
    }
}