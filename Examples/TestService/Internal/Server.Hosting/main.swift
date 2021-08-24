import Configuration;
import Codec;
import Server;
import ServerNio;

import ExampleThirdPartyServerAuthentication;
import ExampleThirdPartyServerRequestLogging;

import ExampleServerActions;
import ExampleServerHelloWorldBackgroundProcess;
import ExampleServerDataAccess;


public class AppConfig {
    public init(_ setting: String)
    {
        Setting = setting;
    };

    public let Setting: String;
}

public class AppConfigV1JsonCodec: JsonCodec<AppConfig> {
    private static let SupportedMediaType: MediaType =
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

let config: AppConfig? = ConfigurationManager()
    .Add(decoder: AppConfigV1JsonCodec())
    .Add(
        file: "/Users/nathan/Documents/Projects/swift/flow/appsettings.json",
        for: MediaType(
            withType: "application",
            withSubtype: "json",
            withParameters: [
                "structure": "example.appsettings",
                "version": "1"
            ]
        )
    )
    .FetchConfig(for: "/Users/nathan/Documents/Projects/swift/flow/appsettings.json");

if let config = config {
    print(config.Setting);
}

try AppRunner(
    withApp:
        AppBuilder()
            .With(httpProcessor: HummingbirdHttpProcessor())
            .Build(),
    withInitializers: [
        //Initializers from "Third Party" code.
        AuthenticationInitializer(),
        RequestLoggingInitializer(),

        //Initializers from other internal projects.
        ActionsInitializer(),
        BackgroundProcessInitializer(),
        WeatherStorageHandlerInitializer(),

        //Initializers defined in this project
        CodecsInitializer(),
        ControllersInitializer(),
        DataAccessLayerInitializer(),
        ErrorTranslatorsInitializer(),
        MiddlewaresInitializer()
    ]
)
    .Run();