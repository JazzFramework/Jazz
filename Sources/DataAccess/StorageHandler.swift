open class StorageHandler<T: Storable> {
    public init() {}

    open func Create(_ model: T) throws {
    }

    open func Delete(id: String) throws {
    }

    open func Update(_ model: T) throws {
    }

    open func Get(id: String) throws -> T? {
        return nil;
    }
}