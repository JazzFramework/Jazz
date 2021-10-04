open class HintHandler<TResource: Storable> {
    open func canHandle(_ hint: QueryHint) -> Bool {
        return false;
    }

    open func canHandle(_ query: Query<TResource>) -> Bool {
        return false;
    }

    open func handle(for query: Query<TResource>, with hint: QueryHint) throws {}
}