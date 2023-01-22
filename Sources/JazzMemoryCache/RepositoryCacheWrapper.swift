import JazzCore;
import JazzDataAccess;

public final class RepositoryCacheWrapper<TResource: Storable>: Repository<TResource> {
    private let repository: Repository<TResource>;
    private let cache: Cache<String, TResource>;

    public init(repository: Repository<TResource>, cache: Cache<String, TResource>) {
        self.repository = repository;
        self.cache = cache;
    }

    public override func create(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        let resource: TResource = try await repository.create(model, with: hints);

        await cache.cache(for: resource.getId(), with: resource);

        return resource;
    }

    public override func delete(id: String, with hints: [QueryHint]) async throws {
        await cache.remove(for: id);

        try await repository.delete(id: id, with: hints);
    }

    public override func update(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        await cache.cache(for: model.getId(), with: model);

        return try await repository.update(model, with: hints);
    }

    public override func get(id: String, with hints: [QueryHint]) async throws -> TResource {
        if let resource: TResource = await cache.fetch(for: id) {
            return resource;
        }

        return try await repository.get(id: id, with: hints);
    }

    public override func get(for query: [QueryCriterion], with hints: [QueryHint]) async throws -> [TResource] {
        return try await repository.get(for: query, with: hints);
    }
}