open class Repository<TResource: Storable> {
    public init() {}

    open func open() async throws {
    }

    open func close() async throws {
    }

    open func create(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        return model;
    }

    open func delete(id: String, with hints: [QueryHint]) async throws {
    }

    open func update(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        return model;
    }

    open func get(id: String, with hints: [QueryHint]) async throws -> TResource {
        throw DataAccessErrors.notFound(reason: "Could not find resource for \(id).");
    }

    open func get(for criteria: [QueryCriterion], with hints: [QueryHint]) async throws -> [TResource] {
        return [];
    }
}