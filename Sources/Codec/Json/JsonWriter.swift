import Foundation;

public class JsonWriter {
    private var _stream: TextOutputStream;

    public init(into stream: TextOutputStream) {
        _stream = stream;
    }

    public func StartObject() {
        _stream.write("{");
    }

    public func EndObject() {
        _stream.write("}");
    }

    public func StartArray() {
        _stream.write("[");
    }

    public func EndArray() {
        _stream.write("]");
    }

    public func WriteDivider() {
        _stream.write(",");
    }
}