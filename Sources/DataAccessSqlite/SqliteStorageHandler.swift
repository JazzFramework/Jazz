import Foundation;

import SQLite;

import DataAccess;

open class SqliteStorageHandler<T: Storable>: StorageHandler<T> {
    public override init() {        
        super.init();
    }

    public override func Create(_ model: T) throws -> T {
        return model;
    }

    public override func Delete(id: String) throws {
    }

    public override func Update(_ model: T) throws -> T {
        return model;
    }

    public override func Get(id: String) throws -> T {
        throw DataAccessErrors.notFound(reason: "Could not find resource for \(id).");
    }

    public override func Get() throws -> [T] {
        throw DataAccessErrors.notFound(reason: "Could not find resources.");
    }
}