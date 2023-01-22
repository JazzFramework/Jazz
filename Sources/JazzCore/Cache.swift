open class Cache<TKey: Hashable, TValue> {
    public init() {}

    open func fetch(for key: TKey) async -> TValue? {
        return nil;
    }

    open func cache(for key: TKey, with value: TValue) async {}

    open func remove(for key: TKey) async {}
}