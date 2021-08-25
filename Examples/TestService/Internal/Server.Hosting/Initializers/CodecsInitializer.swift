import Configuration;
import Server;

import ExampleCommon;
import ExampleServer;

public class CodecsInitializer: Initializer {
    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(transcoder: { _ in
                return WeatherV1JsonCodec();
            })

            .WireUp(transcoder: { _ in
                return WeatherCollectionV1JsonCodec();
            });
    }
}