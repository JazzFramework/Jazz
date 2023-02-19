public final class JsonObjectBuilder {
    private var data: [String: JsonToken];

    public init() {
        data = [:];
    }

    public final func with(_ key: String, property: JsonProperty) -> JsonObjectBuilder {
        data[key] = property;

        return self;
    }

    public final func with(_ key: String, object: JsonObject) -> JsonObjectBuilder {
        data[key] = object;

        return self;
    }

    public final func with(_ key: String, array: JsonArray) -> JsonObjectBuilder {
        data[key] = array;

        return self;
    }

    public final func with<T>(_ key: String, array: [T], logic: (T) -> JsonToken) -> JsonObjectBuilder {
        let arrayBuilder = JsonArrayBuilder();

        for item in array {
            _ = arrayBuilder.with(logic(item));
        }

        data[key] = arrayBuilder.build();

        return self;
    }

    public final func with<T>(_ key: String, object: T, logic: (T) -> JsonObject) -> JsonObjectBuilder {
        data[key] = logic(object);

        return self;
    }

    public final func with<T>(_ key: String, dictionary: [String: T], logic: (T) -> JsonToken) -> JsonObjectBuilder {
        let objectBuilder: JsonObjectBuilder = JsonObjectBuilder();

        for (key, value) in dictionary {
            _ = objectBuilder.with(key, token: logic(value));
        }

        data[key] = objectBuilder.build();

        return self;
    }

    public final func with(_ key: String, token: JsonToken) -> JsonObjectBuilder {
        data[key] = token;

        return self;
    }

    public final func build() -> JsonObject {
        return JsonObject(withData: data);
    }
}