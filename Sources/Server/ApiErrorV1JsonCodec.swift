import Codec;

public class ApiErrorV1JsonCodec: JsonCodec<ApiError> {
    public override func CanHandle(mediaType: MediaType) -> Bool {
        return true;
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
        return ApiError();
    }
}