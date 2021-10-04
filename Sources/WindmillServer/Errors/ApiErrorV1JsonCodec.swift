import WindmillCodec;

internal final class ApiErrorV1JsonCodec: JsonCodec<ApiError> {
    private static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "apierror",
                "version": "1"
            ]
        );

    public override func getSupportedMediaType() -> MediaType {
        return ApiErrorV1JsonCodec.SupportedMediaType;
    }

    public override func encodeJson(data: ApiError, for mediatype: MediaType) async -> JsonObject {
        return JsonObjectBuilder()
            .with("code", property: JsonProperty(withData: "\(data.getCode())"))
            .with("title", property: JsonProperty(withData: data.getTitle()))
            .with("details", property: JsonProperty(withData: data.getDetails()))
            .with("metadata", object: encode(dictionary: data.getMetadata()))
            .build();
    }

    public override func decodeJson(data: JsonObject, for mediatype: MediaType) async -> ApiError? {
        return ApiError(
            withCode: decode(unsignedInteger: "code", from: data),
            withTitle: decode(string: "title", from: data),
            withDetails: decode(string: "details", from: data),
            withMetadata: decode(dictionary: "metadata", from: data)
        );
    }
}