open class JsonCodec<T>: Codec<T> {
    private let reader: JsonObjectReader;
    private let writer: JsonObjectWriter;

    public override init() {
        reader = JsonObjectReader();
        writer = JsonObjectWriter();

        super.init();
    }

    public final override func canHandle(mediaType: MediaType) -> Bool {
        return getSupportedMediaType() == mediaType;
    }

    public final override func canHandle(data: Any) -> Bool
    {
        return data is T;
    }

    public final override func decodeType(
        data: RequestStream,
        for mediaType: MediaType
    ) async -> T? {
        let jsonObject: JsonObject = reader.parse(data);

        return await decodeJson(data: jsonObject);
    }

    public final override func encodeType(
        data: T,
        into stream: ResultStream,
        for mediaType: MediaType
    ) async {
        let jsonObject: JsonObject = await encodeJson(data: data);

        writer.populate(jsonObject, into: stream);
    }

    open func getSupportedMediaType() -> MediaType {
        return MediaType(
            withType: "none",
            withSubtype: "non",
            withParameters: [:]
        );
    }

    open func encodeJson(data: T) async -> JsonObject {
        return JsonObjectBuilder()
            .build();
    }

    open func decodeJson(data: JsonObject) async -> T? {
        return nil;
    }

    public final func encode(dictionary: [String: String]) -> JsonObject {
        let builder: JsonObjectBuilder = JsonObjectBuilder();

        for (key, value) in dictionary {
            _ = builder.with(key, property: JsonProperty(withData: value));
        }

        return builder.build();
    }

    public final func decode(unsignedInteger: String, from data: JsonObject) -> UInt {
        let jsonProperty: JsonProperty? = data[unsignedInteger] as? JsonProperty;

        return jsonProperty?.getUnsignedInteger() ?? 0;
    }

    public final func decode(string: String, from data: JsonObject) -> String {
        let jsonProperty: JsonProperty? = data[string] as? JsonProperty;

        return jsonProperty?.getString() ?? "";
    }

    public final func decode(dictionary: String, from data: JsonObject) -> [String:String] {
        var result: [String: String] = [:];

        if let resultJson = data[dictionary] as? JsonObject {
            for key in resultJson.getKeys()
            {
                if let valueJson = resultJson[key] as? JsonProperty {
                    result[key] = valueJson.getString();
                }
            }
        }

        return result;
    }
}