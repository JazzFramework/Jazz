import DataAccess;
import Server;

import ExampleCommon;

public class WeatherStorageHandlerInitializer: Initializer {
    public init() {}

    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(singleton: { _ in
                return WeatherStorageHandler()
                    as StorageHandler<Weather>;
            });
    }
}