open class BaseHintHandler<TResource: Storable, TQuery: Query<TResource>, THint: QueryHint>: HintHandler<TResource> {
    public override init() {
        super.init();
    }

    public override final func canHandle(_ hint: QueryHint) -> Bool {
        return hint is THint;
    }

    public override final func canHandle(_ query: Query<TResource>) -> Bool {
        return query is TQuery;
    }

    public override final func handle(for query: Query<TResource>, with hint: QueryHint) throws {
        if let typedQuery = query as? TQuery, let typedHint = hint as? THint {
            return process(for: typedQuery, with: typedHint);
        }

        throw DataAccessErrors.notProcessableQuery(reason: "");
    }

    open func process(for query: TQuery, with hint: THint) {}
}