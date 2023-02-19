 public final class CriterionProcessorImpl<TResource: Storable>: CriterionProcessor<TResource> {
    private let criterionHandlers: [CriterionHandler<TResource>]

    public init(criterionHandlers: [CriterionHandler<TResource>]) {
        self.criterionHandlers = criterionHandlers;
    }

    public override final func handle(for query: Query<TResource>, with criteria: [QueryCriterion]) throws {
        for criterion in criteria {
            for criterionHandler in criterionHandlers {
                if criterionHandler.canHandle(query) && criterionHandler.canHandle(criterion) {
                    try criterionHandler.handle(for: query, with: criterion);
                }
            }
        }
    }
}