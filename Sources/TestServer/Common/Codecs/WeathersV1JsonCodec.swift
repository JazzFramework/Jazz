import Codec;

public class WeathersV1JsonCodec: JsonCodec<[Weather]> {
    private static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "example.weathers",
                "version": "1"
            ]
        );

    private static let WeatherV1Codec: WeatherV1JsonCodec =
        WeatherV1JsonCodec();

    public override func GetSupportedMediaType() -> MediaType {
        return WeathersV1JsonCodec.SupportedMediaType;
    }

    public override func EncodeJson(data: [Weather], for mediatype: MediaType) -> JsonObject {
        return JsonObjectBuilder()
            .Build();
    }

    public override func DecodeJson(data: JsonObject, for mediatype: MediaType) -> [Weather]? {
        return [];
    }
}