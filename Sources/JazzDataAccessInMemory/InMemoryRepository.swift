import Foundation;

import JazzDataAccess;

public final class InMemoryRepository<TResource: Storable>: Repository<TResource> {
    private var data: [String: TResource];
    private let lock: NSLock;

    private let criterionProcessor: CriterionProcessor<TResource>;
    private let hintProcessor: HintProcessor<TResource>;

    public init(criterionProcessor: CriterionProcessor<TResource>, hintProcessor: HintProcessor<TResource>) {        
        data = [:];
        lock = NSLock();

        self.criterionProcessor = criterionProcessor;
        self.hintProcessor = hintProcessor;

        super.init();
    }

    public final override func create(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        return lock.withLock() {
            data[model.getId()] = model;

            return model;
        }
    }

    public final override func delete(id: String, with hints: [QueryHint]) async throws {
        _ = lock.withLock() {
            data.removeValue(forKey: id);
        }
    }

    public final override func update(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        return lock.withLock() {
            data[model.getId()] = model;

            return model;
        }
    }

    public final override func get(id: String, with hints: [QueryHint]) async throws -> TResource {
        if let result: TResource = data[id] {
            return result;
        }

        throw DataAccessErrors.notFound(reason: "Could not find resource for \(id).");
    }

    public final override func get(for criteria: [QueryCriterion], with hints: [QueryHint]) async throws -> [TResource] {
        let query: InMemoryQuery<TResource> = getQuery();

        try criterionProcessor.handle(for: query, with: criteria);

        try hintProcessor.handle(for: query, with: hints);

        return query.data;
    }

    private func getQuery() -> InMemoryQuery<TResource> {
        return InMemoryQuery<TResource>(data: Array(data.values));
    }
}