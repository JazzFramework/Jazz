import DataAccess;
import DataAccessInMemory;
import Server;

public class DataAccessLayerInitializer: Initializer {
    public func Initialize(for app: App) throws {
        _ = try app
            .WireUp(singleton: { _ in return InMemoryStorageHandler<Weather>() as StorageHandler<Weather>; })
            .WireUp(singleton: { sp in return WeatherRepository(with: try sp.FetchType()); });
    }
}