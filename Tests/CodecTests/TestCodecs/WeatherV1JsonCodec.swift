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

    public override func getSupportedMediaType() -> MediaType {
        return WeatherV1JsonCodec.SupportedMediaType;
    }

    public override func encodeJson(data: Weather, for mediatype: MediaType) -> JsonObject {
        return JsonObjectBuilder()
            .with("temp", property: JsonProperty(withData: data.Temp))
            .build();
    }

    public override func eecodeJson(data: JsonObject, for mediatype: MediaType) -> Weather? {
        let temp: JsonProperty = data["temp"] as! JsonProperty;

        return Weather(temp.GetString());
    }
}