open class StorageHandler<T: Storable> {
    public init() {}

    open func Create(_ model: T) throws -> T {
        return model;
    }

    open func Delete(id: String) throws {
    }

    open func Update(_ model: T) throws -> T {
        return model;
    }

    open func Get(id: String) throws -> T {
        throw DataAccessErrors.notFound;
    }

    open func Get() throws -> [T] {
        return [];
    }
}