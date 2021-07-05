import Foundation

import DataAccess 

public final class HttpStorageHandler<T: Storable>: StorageHandler<T> {
    private var _data: [String: T];
    private var _lock: NSLock;

    public override init() {        
        _data = [:];

        _lock = NSLock();

        super.init();
    }

    public override func Create(_ model: T) throws -> T {
        _lock.lock()

        _data[model.GetId()] = model;

        _lock.unlock();

        return model;
    }

    public override func Delete(id: String) throws {
        _lock.lock()

        _data.removeValue(forKey: id);

        _lock.unlock();
    }

    public override func Update(_ model: T) throws -> T {
        _lock.lock()

        _data[model.GetId()] = model;

        _lock.unlock();

        return model;
    }

    public override func Get(id: String) throws -> T {
        _lock.lock()

        let result: T? = _data[id];

        _lock.unlock();

        if let result = result {
            return result;
        }

        throw DataAccessErrors.notFound;
    }

    public override func Get() throws -> [T] {
        return Array(_data.values);
    }
}