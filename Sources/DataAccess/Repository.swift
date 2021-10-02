open class Repository<TResource: Storable> {
    public init() {}

    open func Open() async throws {
    }

    open func Close() async throws {
    }

    open func Create(_ model: TResource) async throws -> TResource {
        return model;
    }

    open func Delete(id: String) async throws {
    }

    open func Update(_ model: TResource) async throws -> TResource {
        return model;
    }

    open func Get(id: String) async throws -> TResource {
        throw DataAccessErrors.notFound(reason: "Could not find resource for \(id).");
    }

    open func Get(for query: [QueryCriteria]) async throws -> [TResource] {
        return [];
    }
}