open class CriterionHandler<TResource: Storable> {
    open func canHandle(_ criterion: QueryCriterion) -> Bool {
        return false;
    }

    open func canHandle(_ query: Query<TResource>) -> Bool {
        return false;
    }

    open func handle(for query: Query<TResource>, with criterion: QueryCriterion) throws {}
}