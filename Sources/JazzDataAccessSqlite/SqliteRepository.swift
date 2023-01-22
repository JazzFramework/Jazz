import Foundation;

import JazzDataAccess;

public final class SqliteRepository<TResource: Storable>: Repository<TResource> {
    private let criterionProcessor: CriterionProcessor<TResource>;
    private let hintProcessor: HintProcessor<TResource>;

    public init(criterionProcessor: CriterionProcessor<TResource>, hintProcessor: HintProcessor<TResource>) {        
        self.criterionProcessor = criterionProcessor;
        self.hintProcessor = hintProcessor;

        super.init();
    }

    public final override func open() async throws {
    }

    public final override func close() async throws {
    }

    public final override func create(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        return model;
    }

    public final override func delete(id: String, with hints: [QueryHint]) async throws {
    }

    public final override func update(_ model: TResource, with hints: [QueryHint]) async throws -> TResource {
        return model;
    }

    public final override func get(id: String, with hints: [QueryHint]) async throws -> TResource {
        throw DataAccessErrors.notFound(reason: "Could not find resource for \(id).");
    }

    public final override func get(for criteria: [QueryCriterion], with hints: [QueryHint]) async throws -> [TResource] {
        return [];
    }
}