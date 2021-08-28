import Configuration;
import Server;

import ExampleServer;

public class InMemoryWeatherRepositoryInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { _ in
                return InMemoryWeatherRepository() as WeatherRepository;
            });
    }
}