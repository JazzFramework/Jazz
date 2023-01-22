import JazzDataAccess;

public final class IdQueryCriterionHandler<TResource: Storable>: BaseCriterionHandler<TResource, InMemoryQuery<TResource>, IdQueryCriterion> {
    public override init() {
        super.init();
    }

    public override final func process(for query: InMemoryQuery<TResource>, with criterion: IdQueryCriterion) {
        query.data = query.data.filter({$0.getId() == criterion.getId()});
    }
}