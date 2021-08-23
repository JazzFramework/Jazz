import DataAccess;
import Server;

import ExampleCommon;
import ExampleServer;

public class DataAccessLayerInitializer: Initializer {
    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return WeatherRepository(with: try sp.FetchType());
            });
    }
}