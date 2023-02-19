open class HintProcessor<TResource: Storable> {
    open func handle(for query: Query<TResource>, with criteria: [QueryHint]) throws {}
}