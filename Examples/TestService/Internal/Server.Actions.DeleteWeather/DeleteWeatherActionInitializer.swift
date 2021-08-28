import Configuration;
import Server;

import ExampleServer;

public class DeleteWeatherActionInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return DeleteWeatherAction(
                    with: try sp.FetchType()
                ) as DeleteWeather;
            });
    }
}