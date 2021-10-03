open class Cache<TKey: Hashable, TValue> {
    open func Fetch(for key: TKey) async -> TValue? {
        return nil;
    }

    open func Cache(for key: TKey, with value: TValue) async {
    }

    open func Remove(for key: TKey) async {
    }
}