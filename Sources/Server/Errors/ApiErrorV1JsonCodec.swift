import Codec;

public class ApiErrorV1JsonCodec: JsonCodec<ApiError> {
    private static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "apierror",
                "version": "1"
            ]
        );

    public override func CanHandle(mediaType: MediaType) -> Bool {
        return ApiErrorV1JsonCodec.SupportedMediaType == mediaType;
    }

    public override func CanHandle(data: Any) -> Bool
    {
        return data is ApiError;
    }

    public override func EncodeJson(data: ApiError, for mediatype: MediaType) -> JsonObject {
        return JsonObjectBuilder()
            .With("code", property: JsonProperty(withData: "\(data.GetCode())"))
            .With("title", property: JsonProperty(withData: data.GetTitle()))
            .With("details", property: JsonProperty(withData: data.GetDetails()))
            .With("metadata", object: Encode(metadata: data.GetMetadata()))
            .Build();
    }

    private func Encode(metadata: [String: String]) -> JsonObject
    {
        let builder: JsonObjectBuilder = JsonObjectBuilder();

        for (key, value) in metadata {
            _ = builder.With(key, property: JsonProperty(withData: value));
        }

        return builder.Build();
    }

    public override func DecodeJson(data: JsonObject, for mediatype: MediaType) -> ApiError? {
        return ApiError(
            withCode: 406,
            withTitle: "UnsupportedMediaType",
            withDetails: "UnsupportedMediaType",
            withMetadata: [:]
        );
    }
}