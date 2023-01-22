public final class CollectionJsonCodec<T>: JsonCodec<[T]> {
    private let Codec: JsonCodec<T>;
    private let SupportedMediaType: MediaType;

    public init(withCodec codec: JsonCodec<T>, withMediaType mediaType: MediaType) {
        self.Codec = codec;
        self.SupportedMediaType = mediaType;
    }

    public final override func getSupportedMediaType() -> MediaType {
        return SupportedMediaType;
    }

    public final override func encodeJson(data: [T]) async -> JsonObject {
        let arrayBuilder: JsonArrayBuilder = JsonArrayBuilder();

        for datum in data {
            _ = arrayBuilder.with(
                await Codec.encodeJson(data: datum)
            );
        }

        return JsonObjectBuilder()
            .with("data", array: arrayBuilder.build())
            .with("count", property: JsonProperty(withData: String(data.count)))
            .build();
    }

    public final override func decodeJson(data: JsonObject) async -> [T]? {
        var result: [T] = [];
        let jsonArray: JsonArray = data["data"] as! JsonArray;

        if jsonArray.getCount() > 0 {
            for index in 0...(jsonArray.getCount() - 1) {
                if let jsonObject = jsonArray[index] as? JsonObject {
                    if let datum: T = await Codec.decodeJson(data: jsonObject) {
                        result.append(datum);
                    }
                }
            }
        }

        return result;
    }
}