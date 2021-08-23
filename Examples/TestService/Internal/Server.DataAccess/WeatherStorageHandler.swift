import DataAccess;
import DataAccessInMemory;

import ExampleCommon;

internal final class WeatherStorageHandler: StorageHandler<Weather> {
    private let _storageHandler: InMemoryStorageHandler<Weather>;

    internal override init() {        
        _storageHandler = InMemoryStorageHandler<Weather>();

        super.init();
    }

    public override func Create(_ model: Weather) throws -> Weather {
        return try _storageHandler.Create(model);
    }

    public override func Delete(id: String) throws {
        try _storageHandler.Delete(id: id);
    }

    public override func Update(_ model: Weather) throws -> Weather {
        return try _storageHandler.Update(model);
    }

    public override func Get(id: String) throws -> Weather {
        return try _storageHandler.Get(id: id);
    }

    public override func Get() throws -> [Weather] {
        return try _storageHandler.Get();
    }
}