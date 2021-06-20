import Foundation;

public class JsonObjectWriter {
    public init() {}

    public func Populate(_ jsonObject: JsonObject, into stream: OutputStream) {
        let writer = JsonWriter(into: stream);

        Write(jsonObject: jsonObject, with: writer);
    }

    private func Write(jsonObject: JsonObject, with writer: JsonWriter) {
        writer.StartObject();

        var shouldWriteDivider: Bool = false;
        for key: String in jsonObject.GetKeys() {
            if let token: JsonToken = jsonObject[key] {
                if shouldWriteDivider {
                    writer.WriteDivider();
                }
                else
                {
                    shouldWriteDivider = true;
                }

                writer.Write(key: key);

                Write(token: token, with: writer);
            }
        }

        writer.EndObject();
    }

    private func Write(jsonArray: JsonArray, with writer: JsonWriter) {
        writer.StartArray();

        var shouldWriteDivider: Bool = false;
        for index in 0...jsonArray.GetCount() {
            if let token: JsonToken = jsonArray[index] {
                if shouldWriteDivider {
                    writer.WriteDivider();
                }
                else
                {
                    shouldWriteDivider = true;
                }

                Write(token: token, with: writer);
            }
        }

        writer.EndArray();
    }

    private func Write(jsonProperty: JsonProperty, with writer: JsonWriter) {
        writer.Write(value: jsonProperty.GetString());
    }

    private func Write(token: JsonToken, with writer: JsonWriter) {
        if let jsonObject: JsonObject = token as? JsonObject {
            Write(jsonObject: jsonObject, with: writer);
        }
        else if let jsonArray: JsonArray = token as? JsonArray {
            Write(jsonArray: jsonArray, with: writer);
        }
        else if let jsonProperty: JsonProperty = token as? JsonProperty {
            Write(jsonProperty: jsonProperty, with: writer);
        }
    }
}