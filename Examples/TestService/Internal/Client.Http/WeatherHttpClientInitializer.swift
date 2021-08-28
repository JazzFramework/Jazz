import Configuration;
import Server;

import ExampleCommon;

public class WeatherClientInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { _ in
                return WeatherClientImpl() as WeatherClient;
            });
    }
}