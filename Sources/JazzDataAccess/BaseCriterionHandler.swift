open class BaseCriterionHandler<TResource: Storable, TQuery: Query<TResource>, TCriterion: QueryCriterion>: CriterionHandler<TResource> {
    public override init() {
        super.init();
    }

    public override final func canHandle(_ criterion: QueryCriterion) -> Bool {
        return criterion is TCriterion;
    }

    public override final func canHandle(_ query: Query<TResource>) -> Bool {
        return query is TQuery;
    }

    public override final func handle(for query: Query<TResource>, with criterion: QueryCriterion) throws {
        if let typedQuery = query as? TQuery, let typedCriterion = criterion as? TCriterion {
            process(for: typedQuery, with: typedCriterion);
        }

        throw DataAccessErrors.notProcessableQuery(reason: "");
    }

    open func process(for query: TQuery, with criterion: TCriterion) {}
}