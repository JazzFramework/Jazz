import Foundation;

open class JsonCodec<T>: Codec<T> {
    private let _reader: JsonObjectReader;
    private let _writer: JsonObjectWriter;

    public override init() {
        _reader = JsonObjectReader();
        _writer = JsonObjectWriter();

        super.init();
    }

    public final override func DecodeType(
        data: InputStream,
        for mediaType: MediaType
    ) -> T? {
        let jsonObject: JsonObject = _reader.Parse(data);

        return DecodeJson(data: jsonObject, for: mediaType);
    }

    public final override func EncodeType(
        data: T,
        into stream: OutputStream,
        for mediaType: MediaType
    ) {
        let jsonObject: JsonObject = EncodeJson(data: data, for: mediaType);

        _writer.Populate(jsonObject, into: stream);
    }

    open func EncodeJson(data: T, for mediaType: MediaType) -> JsonObject {
        return JsonObjectBuilder()
            .Build();
    }

    open func DecodeJson(data: JsonObject, for mediaType: MediaType) -> T? {
        return nil;
    }
}