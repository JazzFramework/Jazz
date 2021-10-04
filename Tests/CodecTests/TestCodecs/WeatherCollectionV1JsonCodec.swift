import Codec;

public class WeatherCollectionV1JsonCodec: JsonCodec<[Weather]> {
    private static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "weather.weathers",
                "version": "1"
            ]
        );

    private static let WeatherCodec: WeatherV1JsonCodec =
        WeatherV1JsonCodec();

    public override func getSupportedMediaType() -> MediaType {
        return WeatherCollectionV1JsonCodec.SupportedMediaType;
    }

    public override func encodeJson(data: [Weather], for mediatype: MediaType) -> JsonObject {
        let arrayBuilder: JsonArrayBuilder = JsonArrayBuilder();

        for weather in data {
            _ = arrayBuilder.With(
                WeatherCollectionV1JsonCodec.WeatherCodec.encodeJson(
                    data: weather,
                    for: WeatherCollectionV1JsonCodec.WeatherCodec.getSupportedMediaType()
                )
            );
        }

        return JsonObjectBuilder()
            .With("data", array: arrayBuilder.Build())
            .With("count", property: JsonProperty(withData: String(data.count)))
            .Build();
    }

    public override func decodeJson(data: JsonObject, for mediatype: MediaType) -> [Weather]? {
        var result: [Weather] = [];

        let jsonArray: JsonArray = data["data"] as! JsonArray;

        if jsonArray.GetCount() > 0 {
            for index in 0...(jsonArray.GetCount() - 1) {
                if let jsonObject = jsonArray[index] as? JsonObject {
                    if let weather: Weather = WeatherCollectionV1JsonCodec.WeatherCodec.decodeJson(
                        data: jsonObject,
                        for: WeatherCollectionV1JsonCodec.WeatherCodec.getSupportedMediaType()
                    ) {
                        result.append(weather);
                    }
                }
            }
        }

        return result;
    }
}