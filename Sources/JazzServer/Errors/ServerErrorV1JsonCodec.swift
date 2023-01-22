import JazzCodec;

internal final class ServerErrorV1JsonCodec: JsonCodec<ServerError> {
    private static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "servererror",
                "version": "1"
            ]
        );

    public override func getSupportedMediaType() -> MediaType {
        return ServerErrorV1JsonCodec.SupportedMediaType;
    }

    public override func encodeJson(data: ServerError) async -> JsonObject {
        return JsonObjectBuilder()
            .with("code", property: JsonProperty(withData: "\(data.getCode())"))
            .with("title", property: JsonProperty(withData: data.getTitle()))
            .with("details", property: JsonProperty(withData: data.getDetails()))
            .with("metadata", object: encode(dictionary: data.getMetadata()))
            .build();
    }

    public override func decodeJson(data: JsonObject) async -> ServerError? {
        return ServerErrorBuilder()
            .with(code: decode(unsignedInteger: "code", from: data))
            .with(title: decode(string: "title", from: data))
            .with(details: decode(string: "details", from: data))
            .with(metadata: decode(dictionary: "metadata", from: data))
            .build();
    }
}