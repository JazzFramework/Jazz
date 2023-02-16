open class Repository<TResource: Storable> {
    public init() {}

    open func open() async throws {
    }

    open func close() async throws {
    }

    open func create(_ models: [TResource], with hints: [QueryHint]) async throws -> [TResource] {
        return models;
    }

    open func update(_ models: [TResource], with hints: [QueryHint]) async throws -> [TResource] {
        return models;
    }

    open func delete(for criteria: [QueryCriterion], with hints: [QueryHint]) async throws {}

    open func get(for criteria: [QueryCriterion], with hints: [QueryHint]) async throws -> [TResource] {
        return [];
    }

    public final func create(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        let results = try await create([model], with: hints);

        //TODO: update errors
        if results.isEmpty {
            throw DataAccessErrors.notFound(reason: "Could not find resource.");
        } else if results.count > 1 {
            throw DataAccessErrors.notFound(reason: "Could not find resource, because multiple were found.");
        }

        return results[0];
    }

    public final func update(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        let results = try await update([model], with: hints);

        //TODO: update errors
        if results.isEmpty {
            throw DataAccessErrors.notFound(reason: "Could not find resource.");
        } else if results.count > 1 {
            throw DataAccessErrors.notFound(reason: "Could not find resource, because multiple were found.");
        }

        return results[0];
    }

    public final func delete(id: String, with hints: [QueryHint]) async throws {
        try await delete(for: [IdQueryCriterion(id)], with: hints);
    }

    public final func get(id: String, with hints: [QueryHint]) async throws -> TResource {
        let results: [TResource] = try await get(for: [IdQueryCriterion(id)], with: hints);

        //TODO: update errors
        if results.isEmpty {
            throw DataAccessErrors.notFound(reason: "Could not find resource for \(id).");
        } else if results.count > 1 {
            throw DataAccessErrors.notFound(reason: "Could not find resource for \(id), because multiple were found.");
        }

        return results[0];
    }
}