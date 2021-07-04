import Foundation;

public class JsonWriter {
    private var _stream: OutputStream;

    public init(into stream: OutputStream) {
        _stream = stream;
    }

    public func StartObject() {
        Write(_stream, "{");
    }

    public func EndObject() {
        Write(_stream, "}");
    }

    public func StartArray() {
        Write(_stream, "[");
    }

    public func EndArray() {
        Write(_stream, "]");
    }

    public func WriteDivider() {
        Write(_stream, ",");
    }

    public func Write(key: String) {
        Write(_stream, "\"");

        Write(_stream, Escape(string: key));

        Write(_stream, "\"");

        Write(_stream, ":");
    }

    public func Write(value: String) {
        Write(_stream, "\"");

        Write(_stream, Escape(string: value));

        Write(_stream, "\"");
    }

    private func Write(_ stream: OutputStream, _ data: String) {
        let encodedDataArray = [UInt8](data.utf8)
        _ = stream.write(encodedDataArray, maxLength: encodedDataArray.count);
    }

    private func Escape(string: String) -> String {
        return string.replacingOccurrences(of: "\"", with:"\\\"") 
    }
}