import Foundation;

import DataAccess;

import ExampleCommon;
import ExampleServer;

internal final class InMemoryWeatherRepository: WeatherRepository {
    private var _data: [String: Weather];
    private var _lock: NSLock;

    internal override init() {        
        _data = [:];

        _lock = NSLock();

        super.init();
    }

    public final override func Create(_ model: Weather) throws -> Weather {
        _lock.lock();

        defer {
            _lock.unlock();
        }

        _data[model.GetId()] = model;

        return model;
    }

    public final override func Delete(id: String) throws {
        _lock.lock();

        defer {
            _lock.unlock();
        }

        _data.removeValue(forKey: id);
    }

    public final override func Update(_ model: Weather) throws -> Weather {
        _lock.lock();

        defer {
            _lock.unlock();
        }

        _data[model.GetId()] = model;

        return model;
    }

    public final override func Get(id: String) throws -> Weather {
        let result: Weather? = _data[id];

        if let result = result {
            return result;
        }

        throw DataAccessErrors.notFound(reason: "Could not find resource for \(id).");
    }

    public final override func Get() throws -> [Weather] {
        return Array(_data.values);
    }
}