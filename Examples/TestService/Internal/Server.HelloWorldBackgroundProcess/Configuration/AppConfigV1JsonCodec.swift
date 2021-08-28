import Codec;

public class AppConfigV1JsonCodec: JsonCodec<AppConfig> {
    public static let SupportedMediaType: MediaType =
        MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "example.appsettings",
                "version": "1"
            ]
        );

    public override func GetSupportedMediaType() -> MediaType {
        return AppConfigV1JsonCodec.SupportedMediaType;
    }

    public override func EncodeJson(data: AppConfig, for mediatype: MediaType) -> JsonObject {
        return JsonObjectBuilder()
            .With("setting", property: JsonProperty(withData: data.Setting))
            .Build();
    }

    public override func DecodeJson(data: JsonObject, for mediatype: MediaType) -> AppConfig? {
        let setting: JsonProperty = data["setting"] as! JsonProperty;

        return AppConfig(setting.GetString());
    }
}