public class JsonWriter {
    private var stream: ResultStream;

    public init(into stream: ResultStream) {
        self.stream = stream;
    }

    public func startObject() {
        write(stream, "{");
    }

    public func endObject() {
        write(stream, "}");
    }

    public func startArray() {
        write(stream, "[");
    }

    public func endArray() {
        write(stream, "]");
    }

    public func writeDivider() {
        write(stream, ",");
    }

    public func write(key: String) {
        write(stream, "\"");

        write(stream, escape(string: key));

        write(stream, "\"");

        write(stream, ":");
    }

    public func write(value: String) {
        write(stream, "\"");

        write(stream, escape(string: value));

        write(stream, "\"");
    }

    private func write(_ stream: ResultStream, _ data: String) {
        stream.write(data);
    }

    private func escape(string: String) -> String {
        return string.replacingOccurrences(of: "\"", with:"\\\"") 
    }
}