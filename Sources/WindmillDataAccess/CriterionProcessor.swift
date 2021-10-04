open class CriterionProcessor<TResource: Storable> {
    open func handle(for query: Query<TResource>, with criteria: [QueryCriterion]) throws {}
}