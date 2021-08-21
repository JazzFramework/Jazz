import DataAccess;
import Server;

import ExampleCommon;
import ExampleServer;
import ExampleServerDataAccess;

public class DataAccessLayerInitializer: Initializer {
    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(singleton: { _ in
                return WeatherStorageHandler()
                    as StorageHandler<Weather>;
            })

            .WireUp(singleton: { sp in
                return WeatherRepository(with: try sp.FetchType());
            });
    }
}