import Codec;

public class WeatherV1JsonCodec: JsonCodec<Weather> {
    private static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "test.weather",
                "version": "1"
            ]
        );

    public override func GetSupportedMediaType() -> MediaType {
        return WeatherV1JsonCodec.SupportedMediaType;
    }

    public override func EncodeJson(data: Weather, for mediatype: MediaType) -> JsonObject {
        return JsonObjectBuilder()
            .With("temp", property: JsonProperty(withData: data.Temp))
            .Build();
    }

    public override func DecodeJson(data: JsonObject, for mediatype: MediaType) -> Weather? {
        let temp: JsonProperty = data["temp"] as! JsonProperty;

        return Weather(temp.GetString());
    }
}