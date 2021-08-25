import Configuration;
import DataAccess;
import Server;

import ExampleCommon;
import ExampleServer;

public class DataAccessLayerInitializer: Initializer {
    public func Initialize(for app: App, with configurationBuilder: ConfigurationBuilder) throws {
        _ = try app
            .WireUp(singleton: { sp in
                return WeatherRepository(with: try sp.FetchType());
            });
    }
}