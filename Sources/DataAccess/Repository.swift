open class Repository<TResource: Storable> {
    public init() {}

    open func Open() throws {
    }

    open func Close() throws {
    }

    open func Create(_ model: TResource) throws -> TResource {
        return model;
    }

    open func Delete(id: String) throws {
    }

    open func Update(_ model: TResource) throws -> TResource {
        return model;
    }

    open func Get(id: String) throws -> TResource {
        throw DataAccessErrors.notFound(reason: "Could not find resource for \(id).");
    }

    open func Get() throws -> [TResource] {
        return [];
    }
}