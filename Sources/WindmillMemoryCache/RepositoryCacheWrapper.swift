import WindmillCore;
import WindmillDataAccess;

public final class RepositoryCacheWrapper<TResource: Storable>: Repository<TResource> {
    private let _repository: Repository<TResource>;
    private let _cache: Cache<String, TResource>;

    public init(repository: Repository<TResource>, cache: Cache<String, TResource>) {
        _repository = repository;
        _cache = cache;
    }

    public override func create(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        let resource: TResource = try await _repository.create(model, with: hints);

        await _cache.cache(for: resource.getId(), with: resource);

        return resource;
    }

    public override func delete(id: String, with hints: [QueryHint]) async throws {
        await _cache.remove(for: id);

        try await _repository.delete(id: id, with: hints);
    }

    public override func update(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        await _cache.cache(for: model.getId(), with: model);

        return try await _repository.update(model, with: hints);
    }

    public override func get(id: String, with hints: [QueryHint]) async throws -> TResource {
        if let resource: TResource = await _cache.fetch(for: id) {
            return resource;
        }

        return try await _repository.get(id: id, with: hints);
    }

    public override func get(for query: [QueryCriterion], with hints: [QueryHint]) async throws -> [TResource] {
        return try await _repository.get(for: query, with: hints);
    }
}