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
        if let _ = data as? ApiError {
            return true;
        }

        return false;
    }

    public override func EncodeJson(data: ApiError, for mediatype: MediaType) -> JsonObject {
        return JsonObjectBuilder()
            .With("error", property: JsonProperty(withData: "error"))
            .Build();
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