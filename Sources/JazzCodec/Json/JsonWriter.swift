public final class JsonWriter {
    private var stream: ResultStream;

    public init(into stream: ResultStream) {
        self.stream = stream;
    }

    public final func startObject() {
        write(stream, "{");
    }

    public final func endObject() {
        write(stream, "}");
    }

    public final func startArray() {
        write(stream, "[");
    }

    public final func endArray() {
        write(stream, "]");
    }

    public final func writeDivider() {
        write(stream, ",");
    }

    public final func write(key: String) {
        write(stream, "\"");

        write(stream, escape(string: key));

        write(stream, "\"");

        write(stream, ":");
    }

    public final func write(value: String) {
        write(stream, "\"");

        write(stream, escape(string: value));

        write(stream, "\"");
    }

    private final func write(_ stream: ResultStream, _ data: String) {
        stream.write(data);
    }

    private final func escape(string: String) -> String {
        return string.replacingOccurrences(of: "\"", with:"\\\"") 
    }
}