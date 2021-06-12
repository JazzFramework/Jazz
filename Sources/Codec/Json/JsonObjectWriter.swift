import Foundation;

public class JsonObjectWriter {
    public init() {}

    public func Populate(_ jsonObject: JsonObject, into stream: TextOutputStream) {
        let writer = JsonWriter(into: stream);

        writer.StartObject();

        writer.EndObject();
    }
}