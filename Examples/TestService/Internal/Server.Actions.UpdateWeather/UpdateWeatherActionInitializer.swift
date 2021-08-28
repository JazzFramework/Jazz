import Configuration;
import Server;

import ExampleServer;

public class UpdateWeatherActionInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return UpdateWeatherAction(
                    with: try sp.FetchType()
                ) as UpdateWeather;
            });
    }
}