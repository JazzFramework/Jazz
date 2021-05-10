open class Repository<TResource: Storable, THandler: StorageHandler<TResource>> {
    private let _storageHandler: THandler;

    public init(with storageHandler: THandler) {
        _storageHandler = storageHandler;
    }

    open func Create(_ model: TResource) throws {
        try _storageHandler.Create(model);
    }

    open func Delete(id: String) throws {
        try _storageHandler.Delete(id: id);
    }

    open func Update(_ model: TResource) throws {
        try _storageHandler.Update(model);
    }

    open func Get(id: String) throws -> TResource? {
        return try _storageHandler.Get(id: id);
    }
}