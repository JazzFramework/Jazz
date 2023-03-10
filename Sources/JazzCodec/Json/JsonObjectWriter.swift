public final class JsonObjectWriter {
    public init() {}

    public final func populate(_ jsonObject: JsonObject, into stream: ResultStream) {
        let writer = JsonWriter(into: stream);

        write(jsonObject: jsonObject, with: writer);
    }

    private final func write(jsonObject: JsonObject, with writer: JsonWriter) {
        writer.startObject();

        var shouldWriteDivider: Bool = false;
        for key: String in jsonObject.getKeys() {
            if let token: JsonToken = jsonObject[key] {
                if shouldWriteDivider {
                    writer.writeDivider();
                }
                else
                {
                    shouldWriteDivider = true;
                }

                writer.write(key: key);

                write(token: token, with: writer);
            }
        }

        writer.endObject();
    }

    private final func write(jsonArray: JsonArray, with writer: JsonWriter) {
        writer.startArray();

        if jsonArray.getCount() > 0 {
            var shouldWriteDivider: Bool = false;

            for index in 0...(jsonArray.getCount() - 1) {
                if let token: JsonToken = jsonArray[index] {
                    if shouldWriteDivider {
                        writer.writeDivider();
                    }
                    else
                    {
                        shouldWriteDivider = true;
                    }

                    write(token: token, with: writer);
                }
            }
        }

        writer.endArray();
    }

    private final func write(jsonProperty: JsonProperty, with writer: JsonWriter) {
        writer.write(value: jsonProperty.getString());
    }

    private final func write(token: JsonToken, with writer: JsonWriter) {
        if let jsonObject: JsonObject = token as? JsonObject {
            write(jsonObject: jsonObject, with: writer);
        }
        else if let jsonArray: JsonArray = token as? JsonArray {
            write(jsonArray: jsonArray, with: writer);
        }
        else if let jsonProperty: JsonProperty = token as? JsonProperty {
            write(jsonProperty: jsonProperty, with: writer);
        }
    }
}