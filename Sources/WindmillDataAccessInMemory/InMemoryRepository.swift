import Foundation;

import WindmillDataAccess;

public final class InMemoryRepository<TResource: Storable>: Repository<TResource> {
    private var _data: [String: TResource];
    private var _lock: NSLock;

    private let _criterionProcessor: CriterionProcessor<TResource>;
    private let _hintProcessor: HintProcessor<TResource>;

    public init(criterionProcessor: CriterionProcessor<TResource>, hintProcessor: HintProcessor<TResource>) {        
        _data = [:];
        _lock = NSLock();

        _criterionProcessor = criterionProcessor;
        _hintProcessor = hintProcessor;

        super.init();
    }

    public final override func create(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        return _lock.withLock() {
            _data[model.getId()] = model;

            return model;
        }
    }

    public final override func delete(id: String, with hints: [QueryHint]) async throws {
        _ = _lock.withLock() {
            _data.removeValue(forKey: id);
        }
    }

    public final override func update(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        return _lock.withLock() {
            _data[model.getId()] = model;

            return model;
        }
    }

    public final override func get(id: String, with hints: [QueryHint]) async throws -> TResource {
        if let result: TResource = _data[id] {
            return result;
        }

        throw DataAccessErrors.notFound(reason: "Could not find resource for \(id).");
    }

    public final override func get(for criteria: [QueryCriterion], with hints: [QueryHint]) async throws -> [TResource] {
        let query: InMemoryQuery<TResource> = getQuery();

        try _criterionProcessor.handle(for: query, with: criteria);

        try _hintProcessor.handle(for: query, with: hints);

        return query.data;
    }

    private func getQuery() -> InMemoryQuery<TResource> {
        return InMemoryQuery<TResource>(data: Array(_data.values));
    }
}