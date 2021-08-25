import Configuration;
import DataAccess;
import Server;

import ExampleCommon;

public class WeatherStorageHandlerInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { _ in
                return WeatherStorageHandler()
                    as StorageHandler<Weather>;
            });
    }
}