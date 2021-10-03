import Foundation;

open class JsonCodec<T>: Codec<T> {
    private let _reader: JsonObjectReader;
    private let _writer: JsonObjectWriter;

    public override init() {
        _reader = JsonObjectReader();
        _writer = JsonObjectWriter();

        super.init();
    }

    public final override func CanHandle(mediaType: MediaType) -> Bool {
        return GetSupportedMediaType() == mediaType;
    }

    public final override func CanHandle(data: Any) -> Bool
    {
        return data is T;
    }

    public final override func DecodeType(
        data: InputStream,
        for mediaType: MediaType
    ) async -> T? {
        let jsonObject: JsonObject = _reader.Parse(data);

        return await DecodeJson(data: jsonObject, for: mediaType);
    }

    public final override func EncodeType(
        data: T,
        into stream: OutputStream,
        for mediaType: MediaType
    ) async {
        let jsonObject: JsonObject = await EncodeJson(data: data, for: mediaType);

        _writer.Populate(jsonObject, into: stream);
    }

    open func GetSupportedMediaType() -> MediaType {
        return MediaType(
            withType: "none",
            withSubtype: "non",
            withParameters: [:]
        );
    }

    open func EncodeJson(data: T, for mediaType: MediaType) async -> JsonObject {
        return JsonObjectBuilder()
            .Build();
    }

    open func DecodeJson(data: JsonObject, for mediaType: MediaType) async -> T? {
        return nil;
    }

    public final func Encode(dictionary: [String: String]) -> JsonObject
    {
        let builder: JsonObjectBuilder = JsonObjectBuilder();

        for (key, value) in dictionary {
            _ = builder.With(key, property: JsonProperty(withData: value));
        }

        return builder.Build();
    }

    public final func Decode(unsignedInteger: String, from data: JsonObject) -> UInt {
        let jsonProperty: JsonProperty? = data[unsignedInteger] as? JsonProperty;

        return jsonProperty?.GetUnsignedInteger() ?? 0;
    }

    public final func Decode(string: String, from data: JsonObject) -> String {
        let jsonProperty: JsonProperty? = data[string] as? JsonProperty;

        return jsonProperty?.GetString() ?? "";
    }

    public final func Decode(dictionary: String, from data: JsonObject) -> [String:String] {
        var result: [String: String] = [:];

        if let resultJson = data[dictionary] as? JsonObject {
            for key in resultJson.GetKeys()
            {
                if let valueJson = resultJson[key] as? JsonProperty {
                    result[key] = valueJson.GetString();
                }
            }
        }

        return result;
    }
}