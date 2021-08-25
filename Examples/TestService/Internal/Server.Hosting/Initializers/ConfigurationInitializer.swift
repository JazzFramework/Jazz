import Configuration;
import Server;

import ExampleCommon;
import ExampleServer;

public class ConfigurationInitializer: Initializer {
    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = configurationBuilder
            .With(decoder: AppConfigV1JsonCodec())
            .With(
                file: "appsettings.json",
                for: AppConfigV1JsonCodec.SupportedMediaType
            )
    }
}