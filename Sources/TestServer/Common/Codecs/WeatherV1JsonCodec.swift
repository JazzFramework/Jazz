import Codec;

public class WeatherV1JsonCodec: JsonCodec<Weather> {
    private static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "example.weather",
                "version": "1"
            ]
        );

    public override func CanHandle(mediaType: MediaType) -> Bool {
        return WeatherV1JsonCodec.SupportedMediaType == mediaType;
    }

    public override func CanHandle(data: Any) -> Bool
    {
        /*
        if let _ = data as? Weather {
            return true;
        }

        return false;
        */
        return data is Weather;
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