import Codec;

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

    public override func GetSupportedMediaType() -> MediaType {
        return ApiErrorV1JsonCodec.SupportedMediaType;
    }

    public override func EncodeJson(data: ApiError, for mediatype: MediaType) async -> JsonObject {
        return JsonObjectBuilder()
            .With("code", property: JsonProperty(withData: "\(data.GetCode())"))
            .With("title", property: JsonProperty(withData: data.GetTitle()))
            .With("details", property: JsonProperty(withData: data.GetDetails()))
            .With("metadata", object: Encode(dictionary: data.GetMetadata()))
            .Build();
    }

    public override func DecodeJson(data: JsonObject, for mediatype: MediaType) async -> ApiError? {
        return ApiError(
            withCode: Decode(unsignedInteger: "code", from: data),
            withTitle: Decode(string: "title", from: data),
            withDetails: Decode(string: "details", from: data),
            withMetadata: Decode(dictionary: "metadata", from: data)
        );
    }
}